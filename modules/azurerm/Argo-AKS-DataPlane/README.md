# Argo-AKS-DataPlane

Provisions an Azure-based Argo data plane: an independent AKS cluster that
pulls dispatch tasks from the control plane over NATS (mTLS) and runs the
deploy pipelines.

Tier isolation mirrors the AWS `Argo-EKS-DataPlane` module exactly. Stage
is the cluster's default node pool with its own subnet. Prod is a
separate, tainted node pool with its own subnet and NSG - that NSG
explicitly denies inbound from the stage subnet, which is the real
isolation boundary underneath the taint. Cluster admin access is native
Azure RBAC for Kubernetes, not a unified cross-cloud identity layer.

## Structure

Two independently-callable submodules. This folder itself is not a
module - call `cluster/` and `apps/` separately from your root module.

- [`cluster/`](./cluster) - the AKS cluster, VNet (stage/prod tiers, each
  with its own NAT Gateway and subnets), Workload Identity Federation
  identities, and optional Azure Bastion.
- [`apps/`](./apps) - the Kubernetes-level install: Argo Workflows, Argo
  Events, ArgoCD, External Secrets Operator, and caller-supplied
  project-specific manifests.

## How the two compose

`apps` does not take cluster credentials as an input variable. It
inherits the `kubernetes`/`helm`/`kubectl` provider configuration the
caller sets up against a `data.azurerm_kubernetes_cluster` lookup of
`cluster`'s resulting AKS cluster. (`cluster` deliberately exposes no
non-admin `kube_config` output of its own, to avoid ever touching AKS's
local-account admin credential.) The caller also wires specific `cluster`
outputs directly into `apps` inputs:
`workflow_controller_artifacts_client_id`/`artifact_storage_account_name`
for Argo Workflows' Blob Storage artifact archiving, and
`deploy_identity_client_ids` entries into `apps`'
`federated_service_accounts` for any Workload-Identity-authenticated
workload (e.g. External Secrets Operator's `ClusterSecretStore`). Build
`federated_service_accounts` from `cluster`'s `deploy_identity_client_ids`
output, the same way `environments/azure-dataplane/main.tf` does.

`cluster`'s AKS cluster must exist before the `kubernetes`/`helm`
providers `apps` uses can authenticate against it. A root module calling
both needs a two-step apply: `terraform apply -target=module.cluster`
first, then a plain `terraform apply`. See `cloud-sre-common`'s
`environments/azure-dataplane` for a real, wired-up example.

**Apply this module after the `Argo-Control-Plane` module (AWS or Azure,
whichever hosts the control plane), not before.** This data plane's own NATS client identity (e.g.
`azure-stage`/`azure-prod`) has to already exist as a cert-manager-issued
certificate in the control plane's output, copied by hand into this
module's `terraform.tfvars`, before `apps` can dial the control plane
over NATS. It has no dependency on the AWS data plane
(`Argo-EKS-DataPlane`) and can be applied before, after, or in parallel
with it.

## Example

```hcl
module "cluster" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-AKS-DataPlane/cluster?ref=v1.0.0"

  resource_group_name = "rg-asgardeo-argo-azure-dataplane"
  location             = "eastus"

  vnet_name          = "vnet-aks-argo-azure-dataplane"
  vnet_address_space = "10.2.0.0/16"

  aks_cluster_name = "aks-argo-azure-dataplane"
  aks_dns_prefix   = "aks-argo-azure-dataplane"

  kubernetes_version = "1.34"
  service_cidr        = "10.100.0.0/16"
  dns_service_ip       = "10.100.0.10"

  log_analytics_workspace_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.OperationalInsights/workspaces/..."
  aks_public_ssh_key_path     = "~/.ssh/id_rsa.pub"
  aks_admin_group_object_ids  = ["00000000-0000-0000-0000-000000000000"]

  stage_subnet_address_prefix       = "10.2.1.0/24"
  stage_node_vm_size                = "Standard_D2s_v5"
  internal_lb_subnet_address_prefix = "10.2.20.0/27"

  prod_subnet_address_prefix = "10.2.2.0/24"
  prod_node_vm_size          = "Standard_D2s_v5"
}

module "apps" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-AKS-DataPlane/apps?ref=v1.0.0"

  namespaces = ["argo-azure-stage", "argo-azure-prod"]

  install_external_secrets = true

  depends_on = [module.cluster]
}
```

See [`cluster/README.md`](./cluster/README.md) and
[`apps/README.md`](./apps/README.md) for each submodule's full inputs and
outputs.
