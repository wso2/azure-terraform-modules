# Argo-AKS-DataPlane/cluster

Provisions the AKS cluster and tier-isolated networking an Azure Argo
data plane runs on. Stage is the cluster's default node pool with its own
subnet. Prod is a separate, tainted node pool with its own subnet and NSG
that explicitly denies inbound from the stage subnet.

Raw `azurerm_*` resource blocks. No dependency on any other WSO2 module
repo.

## What it provisions

- A resource group (opt-in via `create_resource_group`, default true - set
  false to point at one already managed elsewhere without this module
  owning its lifecycle).
- A VNet with stage, prod, and internal-load-balancer subnets, per-tier
  NSGs (prod's denies inbound from the stage subnet), and per-tier NAT
  Gateways (own outbound IP each).
- The AKS cluster: stage as the default node pool, prod as a separate
  tainted+labeled node pool, Azure RBAC for Kubernetes cluster-admin
  (`aks_admin_group_object_ids`), OIDC issuer and Workload Identity
  enabled, optional private-only API endpoint or authorized IP ranges.
- Optional etcd secrets encryption via a Key Vault + key
  (`enable_secrets_encryption`).
- Optional NSG Flow Logs (`enable_vpc_flow_logs`) to a dedicated storage
  account.
- An optional Storage Account + container + Workload Identity Federation
  identity for Argo Workflows' artifact archiving
  (`enable_artifact_archiving`), same shape as `Argo-EKS-DataPlane/cluster`'s
  S3 bucket + IRSA role.
- An optional Azure Bastion (`enable_bastion`) with its own subnet, public
  IP, and the full set of NSG rules Azure Bastion requires.
- Per-env Workload Identity Federation identities for pipeline pods
  (`deploy_identities`) - one User-Assigned Managed Identity + Federated
  Identity Credential per entry, trust scoped to exactly one `(namespace,
  ServiceAccount)` subject.

## Notes

- `enable_secrets_encryption` can only be turned on in a follow-up apply
  after the cluster already exists. The cluster's own system-assigned
  identity can't be granted Key Vault access before the cluster exists.
- Azure retired creation of *new* NSG flow logs as of 2025-06-30 (existing
  ones keep working until 2027-09-30). This module hasn't yet migrated to
  VNet flow logs (Network Manager), so `enable_vpc_flow_logs` currently
  400s on any fresh environment regardless of the setting.
- `deploy_identities` only creates the identity. Actual permissions are
  granted separately via `deploy_identity_role_assignments`, gated on
  `create_role_assignments` - granting Azure RBAC roles needs
  `Microsoft.Authorization/roleAssignments/write`, which a plain
  Contributor identity doesn't have.

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `resource_group_name` | `string` | required | Resource group for the data plane (AKS, VNet, NAT Gateways, Bastion) |
| `create_resource_group` | `bool` | `true` | Whether this module creates `resource_group_name` itself, vs. pointing at one already managed elsewhere |
| `create_role_assignments` | `bool` | `true` | Whether to create the `azurerm_role_assignment` resources this module wires up. Requires `Microsoft.Authorization/roleAssignments/write` at the relevant scope. Set false to still create identities/federated credentials but skip granting roles |
| `location` | `string` | required | Azure region |
| `tags` | `map(string)` | `{}` | |
| `vnet_name` | `string` | required | |
| `vnet_address_space` | `string` | required | e.g. `10.2.0.0/16` |
| `aks_cluster_name` | `string` | required | |
| `aks_dns_prefix` | `string` | required | |
| `kubernetes_version` | `string` | required | |
| `aks_admin_username` | `string` | `"azureuser"` | |
| `aks_public_ssh_key_path` | `string` | required | Path to the public SSH key file for AKS nodes |
| `aks_admin_group_object_ids` | `list(string)` | `[]` | Entra ID group object IDs granted AKS cluster-admin via native Azure RBAC for Kubernetes |
| `private_cluster_enabled` | `bool` | `false` | |
| `api_server_authorized_ip_ranges` | `list(string)` | `[]` | |
| `service_cidr` | `string` | required | |
| `log_analytics_workspace_id` | `string` | required | Resource ID of an existing Log Analytics Workspace for AKS's `oms_agent`. This module does not create one |
| `dns_service_ip` | `string` | required | Must be inside `service_cidr` |
| `stage_subnet_address_prefix` | `string` | required | CIDR for the stage tier's node pool subnet |
| `internal_lb_subnet_address_prefix` | `string` | required | CIDR for AKS's internal load balancer subnet (shared infra, not tier-specific) |
| `stage_node_vm_size` | `string` | required | |
| `stage_availability_zones` | `list(number)` | `[1, 2, 3]` | |
| `stage_node_min_count` | `number` | `1` | |
| `stage_node_max_count` | `number` | `3` | |
| `prod_subnet_address_prefix` | `string` | required | CIDR for the prod tier's dedicated subnet |
| `prod_node_vm_size` | `string` | required | |
| `prod_availability_zones` | `list(string)` | `["1", "2", "3"]` | |
| `prod_node_min_count` | `number` | `1` | |
| `prod_node_max_count` | `number` | `3` | |
| `prod_node_taint_value` | `string` | `"prod"` | Value for the `env` taint applied to prod nodes |
| `enable_bastion` | `bool` | `true` | |
| `bastion_subnet_address_prefix` | `string` | `null` | Must be `/26` or larger per Azure's requirement |
| `bastion_allow_https_internet_inbound` | `bool` | `false` | Whether Bastion accepts inbound from the public internet vs. only `bastion_public_address_prefixes` |
| `bastion_public_address_prefixes` | `list(string)` | `[]` | Source CIDRs allowed to reach Bastion when `bastion_allow_https_internet_inbound` is false |
| `deploy_identities` | `map(object({ namespace, service_account_name }))` | `{}` | Per-env Workload Identity Federation identities for pipeline pods. See Notes above |
| `deploy_identity_role_assignments` | `list(object({ identity_key, role_definition_name, scope }))` | `[]` | Azure RBAC role assignments granting each deploy identity access to its real deployment target - a list since one identity may need more than one role/scope |
| `enable_secrets_encryption` | `bool` | `false` | Enables AKS's etcd secrets encryption via a Key Vault + key. See Notes above |
| `log_retention_in_days` | `number` | `90` | |
| `enable_vpc_flow_logs` | `bool` | `false` | Whether to create NSG Flow Logs for the stage/prod NSGs. See Notes above |
| `network_watcher_name` | `string` | `null` | Required when `enable_vpc_flow_logs` is true |
| `network_watcher_resource_group_name` | `string` | `null` | Required when `enable_vpc_flow_logs` is true |
| `enable_artifact_archiving` | `bool` | `false` | |
| `argo_namespace` | `string` | `"argo"` | |
| `workflow_controller_service_account_name` | `string` | `"argo-workflows-workflow-controller"` | |
| `argo_logs_storage_account_name` | `string` | `null` | Explicit override. Storage account names are `ForceNew` (renaming destroys/recreates, losing archived logs), so an already-applied environment must pin its current live name here |
| `flow_logs_storage_account_name` | `string` | `null` | Same override, for the flow-logs storage account |

## Outputs

| Name | Description |
|---|---|
| `aks_cluster_name` | |
| `aks_cluster_id` | |
| `kubernetes_cluster_fqdn` | |
| `kubernetes_cluster_private_fqdn` | |
| `aks_oidc_issuer_url` | |
| `virtual_network_name` | |
| `stage_subnet_id` | |
| `prod_subnet_id` | |
| `bastion_host_id` | `null` unless `enable_bastion` |
| `deploy_identity_client_ids` | Client ID per `deploy_identities` entry. Annotate the matching ServiceAccount with `azure.workload.identity/client-id: <this value>` |
| `workflow_controller_artifacts_client_id` | `null` unless `enable_artifact_archiving`. The pod also needs the `azure.workload.identity/use: "true"` label for AKS's webhook to inject the token |
| `artifact_storage_account_name` | `null` unless `enable_artifact_archiving` |

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

  deploy_identities = {
    "is-deploy-stage" = {
      namespace             = "argo-azure-stage"
      service_account_name  = "asgardeo-is-deploy-sa"
    }
  }
}
```
