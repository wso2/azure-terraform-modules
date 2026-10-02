# Argo-Control-Plane (azurerm)

Provisions the Argo control plane on Azure. The control plane is the
single, cloud-agnostic hub that dispatches tasks to data planes over NATS
(mTLS) and waits for their results. It holds no cloud credentials and runs
no deploy workloads itself.

This is the Azure alternative to the AWS
[`Argo-Control-Plane`](https://github.com/wso2/aws-terraform-modules/tree/main/modules/aws/Argo-Control-Plane)
module. Use one or the other - there is only ever one control plane. Its
outputs use the same names as the AWS module's, so the data planes
(the AWS and Azure `Argo-Data-Plane` modules) consume it the same way
whichever cloud it runs in.

Portal SSO is not part of this module. `modules/azuread/Argo-Entra-SSO`
provides it, and works unchanged in front of either cloud's control plane.

## Structure

Two independently-callable submodules. This folder itself is not a
module - call `cluster/` and `apps/` separately from your root module.

- [`cluster/`](./cluster) - the Azure infrastructure: AKS, VNet, NAT
  Gateway, Key Vaults (KMS and ESO), Workload Identities, optional
  Bastion. Nothing Kubernetes-level.
- [`apps/`](./apps) - everything inside the cluster: NATS (JetStream, mTLS
  via cert-manager), Argo Workflows, Argo Events, cert-manager, Traefik,
  External Secrets Operator, and caller-supplied manifests.

## How the two compose

The caller looks up the AKS cluster with a `data.azurerm_kubernetes_cluster`
on `cluster`'s `aks_cluster_name`/`resource_group_name` outputs and
configures the `kubernetes`/`helm`/`kubectl` providers against it, using
`kubelogin` in `azurecli` mode (the same as `Argo-Data-Plane`), so
`kubelogin` and a logged-in `az` CLI are required wherever this runs.
`apps` inherits those providers.

Pass `module.cluster.eso_client_id` into `apps`' `eso_client_id`, and give
both submodules the same `eso_namespace`, so ESO's federated identity
subject matches where ESO is installed.

## Notes

- **Two-step first apply.** The AKS cluster must exist before the
  `kubernetes`/`helm` providers can authenticate:
  `terraform apply -target=module.cluster`, then a plain
  `terraform apply`.
- **Apply this module before any data plane.** `apps` issues each data
  plane's NATS client certificate (`nats_client_identities`) and,
  optionally, reverse-tunnel SSH keys (`tunnel_client_identities`). Copy
  the sensitive outputs (`nats_client_cert_pems`/`nats_client_key_pems`/
  `nats_client_ca_pems`, `tunnel_client_private_keys`) into each data
  plane's own `terraform.tfvars`. There is no remote-state link, so a data
  plane never gets read access to this module's state.
- **Seed ESO's secrets before the gateway needs them.** Put the
  oauth2-proxy cookie secret and SSO client secret into the Key Vault at
  `eso_key_vault_uri`, then point a `ClusterSecretStore` at it (example in
  [`apps/README.md`](./apps/README.md)).
- **NATS external access** works the same as on AWS: expose NATS through a
  public LoadBalancer Service (via `manifest_files`/`nats_values`) and add
  its hostname to `nats_server_external_dns_names`.

## Example

```hcl
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "cluster" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-Control-Plane/cluster?ref=v1.0.0"

  resource_group_name = "rg-argo-controlplane-prod"
  location            = "eastus2"

  vnet_name                  = "vnet-argo-controlplane-prod"
  vnet_address_space         = "10.4.0.0/16"
  node_subnet_address_prefix = "10.4.0.0/22"

  aks_cluster_name        = "aks-argo-controlplane-prod"
  aks_dns_prefix          = "argo-cp-prod"
  kubernetes_version      = "1.31"
  aks_public_ssh_key_path = "~/.ssh/aks.pub"
  service_cidr            = "10.100.0.0/16"
  dns_service_ip          = "10.100.0.10"

  aks_admin_group_object_ids = ["00000000-0000-0000-0000-000000000000"]
  node_vm_size               = "Standard_D4s_v5"

  enable_bastion                = true
  bastion_subnet_address_prefix = "10.4.8.0/26"
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = module.cluster.aks_cluster_name
  resource_group_name = module.cluster.resource_group_name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--login", "azurecli", "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630"]
  }
}

# Configure "helm" and "kubectl" the same way.

module "apps" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-Control-Plane/apps?ref=v1.0.0"

  extra_namespaces = ["oauth2-proxy", "gateway"]

  nats_client_identities         = ["control-plane", "azure-stage", "azure-prod", "aws-stage", "aws-prod"]
  tunnel_client_identities       = ["aws", "azure"]
  nats_server_external_dns_names = ["nats.argo.example.com"]

  install_external_secrets = true
  eso_client_id            = module.cluster.eso_client_id

  depends_on = [module.cluster]
}
```

See [`cluster/README.md`](./cluster/README.md) and
[`apps/README.md`](./apps/README.md) for each submodule's full inputs and
outputs.
