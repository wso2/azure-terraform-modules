# Argo-Control-Plane/cluster (azurerm)

Provisions the AKS cluster, VNet, and supporting identity/networking the
Argo control plane runs on, for when the control plane lives in Azure
instead of AWS. The control plane itself holds no cloud credentials and
runs no deploy workloads; this module only builds the cluster it lives on.

Raw `azurerm_*` resource blocks, no dependency on any other WSO2 module
repo. Network, KMS, Bastion and Workload Identity shapes are the same as
`Argo-Data-Plane/cluster`, collapsed to a single shared node pool -
the control plane has no stage/prod tier split.

## AWS to Azure mapping

| AWS `Argo-Control-Plane/cluster` | This module |
|---|---|
| VPC + per-AZ subnets + per-AZ NAT Gateways | VNet + one node subnet + one NAT Gateway |
| Node security group + `security_group_rules` | Node subnet NSG + `network_security_rules` |
| EKS + managed node group | AKS + `system` default node pool (autoscaling) |
| `admin_principal_arns` access entries | `aks_admin_group_object_ids` (Entra ID + Azure RBAC) |
| EKS default envelope encryption (AWS owned key) | Key Vault key + AKS KMS (`enable_secrets_encryption`) |
| OIDC provider + IRSA roles | AKS OIDC issuer + User-Assigned Identity + Federated Credential |
| ESO role scoped to a Secrets Manager prefix | ESO identity with `Key Vault Secrets User` on a dedicated Key Vault |
| S3 artifact bucket + IRSA role | Storage Account + container + Workload Identity |
| VPC Flow Logs | VNet flow logs (existing Network Watcher) |
| SSM-only bastion instance | Azure Bastion (Standard, tunneling enabled) |
| EBS CSI addon + IRSA | Nothing - AKS ships the Azure Disk CSI driver |

## What it provisions

- A resource group (opt-out via `create_resource_group = false`).
- A VNet with one node subnet, an NSG with caller-supplied rules, and a
  NAT Gateway giving all egress one static IP (`nat_gateway_public_ip`).
- The AKS cluster: Azure CNI, Entra ID integration with Azure RBAC, OIDC
  issuer + Workload Identity, optional private API server, optional
  Container Insights, one autoscaling `system` node pool across
  `availability_zones`.
- Optional KMS etcd encryption: a purge-protected Key Vault + RSA key, and
  the role assignments AKS needs to use it.
- A dedicated, purge-protected Key Vault for External Secrets Operator,
  plus a User-Assigned Identity federated to ESO's controller
  ServiceAccount with `Key Vault Secrets User` on that vault. The identity
  running `terraform apply` gets `Key Vault Secrets Officer` on it so it
  can seed secrets.
- An optional VNet flow log, Argo Workflows artifact storage (Storage Account
  + container + federated identity with `Storage Blob Data Contributor`),
  and Azure Bastion.

## Notes

- **API server access is open by default.** With `private_cluster_enabled`
  false and `api_server_authorized_ip_ranges` empty, the API server accepts
  connections from any address; only Entra ID sign-in protects it. Set one
  of the two for anything beyond a test cluster. If you set IP ranges,
  include this cluster's NAT gateway addresses.
- **The local admin account stays enabled by default**, which leaves a
  credential that bypasses Azure RBAC. Set `local_account_disabled = true`
  once an admin group or role assignment exists; doing it earlier locks
  everyone out.
- **The cluster uses a user-assigned identity** (`<aks_cluster_name>-identity`).
  AKS KMS doesn't work with a system-assigned one, and this lets the Key
  Vault and VNet grants exist before the cluster is created, so
  `enable_secrets_encryption` works on the first apply. Changing an
  existing cluster from system-assigned to user-assigned is an in-place
  update, but plan it carefully on a live cluster.
- **ESO's federated subject is `<eso_namespace>:external-secrets`.**
  Keep `eso_namespace` in sync with the `apps` module's.
- **Role assignments need Owner or User Access Administrator.** With only
  Contributor, set `create_role_assignments = false` and have someone with
  the right access create the grants separately. The cluster identity's
  `Network Contributor` on the VNet must exist before the cluster is
  created. The KMS grants are not gated by this flag, since KMS can't
  work without them.
- Key Vault names are global and purge protection holds a deleted vault's
  name for 90 days. Pin `eso_key_vault_name` /
  `cluster_secrets_key_vault_name` if you need to rebuild in the same
  window.
- `availability_zones` needs at least 2 entries; NATS JetStream runs 3
  replicas, so use 3 zones for a RAFT quorum that survives a zone outage.
- The identity running `terraform apply` must be in one of
  `aks_admin_group_object_ids` (or otherwise hold an AKS RBAC admin role)
  for the `apps` module to authenticate.

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `resource_group_name` | `string` | required | Resource group for all control-plane resources |
| `create_resource_group` | `bool` | `true` | Whether this module creates the resource group |
| `create_role_assignments` | `bool` | `true` | Whether to create the cluster-identity network grant and the ESO and artifact-identity role assignments. See Notes |
| `location` | `string` | required | Azure region |
| `tags` | `map(string)` | `{}` | |
| `vnet_name` | `string` | required | |
| `vnet_address_space` | `string` | required | e.g. `10.4.0.0/16` |
| `node_subnet_address_prefix` | `string` | required | CIDR for the AKS node subnet |
| `network_security_rules` | `list(object({ name, priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix }))` | `[]` | Extra rules on the node subnet NSG |
| `aks_cluster_name` | `string` | required | Also the prefix for every derived resource name |
| `aks_dns_prefix` | `string` | required | |
| `kubernetes_version` | `string` | required | |
| `aks_admin_username` | `string` | `"azureuser"` | |
| `aks_public_ssh_key_path` | `string` | required | Path to the node admin public SSH key |
| `aks_admin_group_object_ids` | `list(string)` | `[]` | Entra ID groups granted cluster-admin |
| `private_cluster_enabled` | `bool` | `false` | |
| `api_server_authorized_ip_ranges` | `list(string)` | `[]` | Empty leaves the public endpoint open to any address. See Notes |
| `local_account_disabled` | `bool` | `false` | Disable the local admin account. See Notes |
| `service_cidr` | `string` | required | Must not overlap the VNet |
| `dns_service_ip` | `string` | required | Must be inside `service_cidr` |
| `log_analytics_workspace_id` | `string` | `null` | Existing workspace for Container Insights. Null disables it |
| `node_vm_size` | `string` | required | |
| `availability_zones` | `list(string)` | `["1", "2", "3"]` | At least 2 |
| `node_min_count` | `number` | `2` | |
| `node_max_count` | `number` | `4` | |
| `enable_bastion` | `bool` | `true` | |
| `bastion_subnet_address_prefix` | `string` | `null` | `/26` or larger. Required when `enable_bastion` |
| `bastion_allow_https_internet_inbound` | `bool` | `false` | |
| `bastion_public_address_prefixes` | `list(string)` | `[]` | |
| `enable_secrets_encryption` | `bool` | `false` | Key Vault-backed KMS etcd encryption |
| `cluster_secrets_key_vault_name` | `string` | `null` | Override; null derives `<aks_cluster_name>-kms` |
| `eso_namespace` | `string` | `"external-secrets"` | |
| `eso_key_vault_name` | `string` | `null` | Override; null derives `<aks_cluster_name>-secrets` |
| `log_retention_in_days` | `number` | `90` | |
| `enable_vpc_flow_logs` | `bool` | `false` | Creates a VNet flow log for this module's VNet |
| `network_watcher_name` | `string` | `null` | Required when `enable_vpc_flow_logs` |
| `network_watcher_resource_group_name` | `string` | `null` | Required when `enable_vpc_flow_logs` |
| `enable_artifact_archiving` | `bool` | `false` | |
| `argo_namespace` | `string` | `"argo"` | |
| `workflow_controller_service_account_name` | `string` | `"argo-workflows-workflow-controller"` | |
| `argo_logs_storage_account_name` | `string` | `null` | Override for the ForceNew storage account name |
| `flow_logs_storage_account_name` | `string` | `null` | Same, for flow logs |

## Outputs

| Name | Description |
|---|---|
| `aks_cluster_name` | |
| `aks_cluster_id` | |
| `kubernetes_cluster_fqdn` | |
| `kubernetes_cluster_private_fqdn` | |
| `aks_oidc_issuer_url` | |
| `resource_group_name` | |
| `virtual_network_name` | |
| `node_subnet_id` | |
| `nat_gateway_public_ip` | Static egress IP for the whole control plane |
| `bastion_host_id` | `null` unless `enable_bastion` |
| `eso_client_id` | Workload Identity client ID for ESO's controller ServiceAccount |
| `eso_key_vault_uri` | `vaultUrl` for the `ClusterSecretStore` |
| `eso_key_vault_id` | |
| `workflow_controller_artifacts_client_id` | `null` unless `enable_artifact_archiving` |
| `artifact_storage_account_name` | `null` unless `enable_artifact_archiving` |

## Example

```hcl
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

  node_vm_size = "Standard_D4s_v5"

  enable_bastion                = true
  bastion_subnet_address_prefix = "10.4.8.0/26"

  enable_artifact_archiving = true
}
```
