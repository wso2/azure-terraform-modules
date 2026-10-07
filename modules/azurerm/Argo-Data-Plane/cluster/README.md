# Argo-Data-Plane/cluster

Provisions the AKS cluster and tier-isolated networking an Azure Argo
data plane runs on. A dedicated, always-on system pool runs AKS's own
add-ons (CoreDNS, metrics-server, konnectivity-agent); stage and prod are
each a separate, tainted-where-relevant node pool with their own subnet,
and prod's NSG explicitly denies inbound from the stage subnet. Pod-to-pod
separation between the tiers comes from NetworkPolicy (see Notes).

Raw `azurerm_*` resource blocks. No dependency on any other WSO2 module
repo.

## What it provisions

- A resource group (opt-in via `create_resource_group`, default true - set
  false to point at one already managed elsewhere without this module
  owning its lifecycle).
- A VNet with system, stage, prod, and internal-load-balancer subnets,
  NSGs (prod's denies inbound from the stage subnet; system has none, so
  it can always reach either tier), and NAT Gateways (own outbound IP
  each for system/stage/prod).
- The AKS cluster: a small system pool as the required default node pool
  (tainted `CriticalAddonsOnly`, which AKS's own add-ons already
  tolerate), stage and prod as separate node pools (prod
  tainted+labeled), Azure CNI Overlay (pod IPs don't consume subnet
  space - see Notes), Azure RBAC for Kubernetes cluster-admin
  (`aks_admin_group_object_ids`), OIDC issuer and Workload Identity
  enabled, optional private-only API endpoint or authorized IP ranges.
- Optional etcd secrets encryption via a Key Vault + key
  (`enable_secrets_encryption`).
- An optional VNet flow log (`enable_vpc_flow_logs`) to a dedicated storage
  account.
- An optional Storage Account + container + Workload Identity Federation
  identity for Argo Workflows' artifact archiving
  (`enable_artifact_archiving`), same shape as the AWS
  `Argo-Data-Plane/cluster` module's S3 bucket + IRSA role.
- An optional Azure Bastion (`enable_bastion`) with its own subnet, public
  IP, and the full set of NSG rules Azure Bastion requires.
- Per-env Workload Identity Federation identities for pipeline pods
  (`deploy_identities`) - one User-Assigned Managed Identity + Federated
  Identity Credential per entry, trust scoped to exactly one `(namespace,
  ServiceAccount)` subject.

## Notes

- **The API server is private by default**, the same as the AWS modules'
  private EKS endpoint. Setting `private_cluster_enabled = false` with
  `api_server_authorized_ip_ranges` empty opens it to any address, with
  only Entra ID sign-in protecting it. If you set IP ranges, include this
  cluster's NAT gateway addresses.
- **A private cluster needs the jump VM.** Bastion only carries SSH and RDP
  to a VM; it can't forward to the API server's port 443. With
  `private_cluster_enabled = true`, set `enable_bastion` and
  `enable_jump_vm` and connect with
  `az network bastion ssh --name <aks_cluster_name>-bastion --resource-group <rg> --target-resource-id <jump_vm_id> --auth-type ssh-key --username azureuser --ssh-key <private key>`.
  The VM has `az`, `kubectl` and `kubelogin` installed.
- **Give groups, not people, the path in.** Each entry in `jump_vm_access`
  gets Entra SSH login on the jump VM (`--auth-type AAD`), `Reader` on the
  VM, its NIC and the Bastion host, and the AKS Cluster User role, which is
  everything needed to get from Bastion to a kubeconfig. It grants no
  Kubernetes permissions: use `aks_admin_group_object_ids` for
  cluster-admins and the apps module's `group_role_bindings` for
  per-namespace access. Once those work, set `local_account_disabled`.
  `terraform apply` of anything that talks to the Kubernetes API has to
  reach it through that VM too.
- **The local admin account stays enabled by default**, which leaves a
  credential that bypasses Azure RBAC. Set `local_account_disabled = true`
  once an admin group or role assignment exists; doing it earlier locks
  everyone out.
- Stage and prod networking (subnet, NSG, NAT gateway) is built from one
  set of resource blocks that iterate over `local.tiers`. Those resources
  are addressed by tier, e.g. `azurerm_subnet.tier["prod"]`. The system
  pool's subnet/NSG/NAT gateway are separate, singular resources - it
  isn't a third tier, just dedicated infrastructure for cluster add-ons.
- **Azure CNI Overlay, not flat Azure CNI.** Flat CNI assigns every pod a
  real, routable VNet IP, so a tier's subnet must be sized for `max_pods
  x node count`, not just node count - a modest subnet exhausts fast.
  Overlay pod IPs (`pod_cidr`) are never routed on the VNet, so subnet
  sizing only has to cover node IPs. `pod_cidr` must not overlap
  `vnet_address_space` or `service_cidr`.
- **The stage-to-prod NSG rule is not enough on its own under overlay.**
  Overlay pod traffic is not encapsulated and keeps its `pod_cidr` source
  address, and `pod_cidr` is handed out per node, not per tier, so a
  subnet rule cannot tell a stage pod from a prod pod. The rule still
  blocks what leaves a stage node with the node's address (host-network
  pods, and stage pods calling a prod node IP or NodePort). Pod-to-pod
  traffic between tiers is blocked by `enable_network_policy` together
  with the `apps` module's `namespace_tiers`; keep both on.
- **The system pool exists because of a real interaction**: AKS requires
  exactly one default node pool in System mode, and that pool is where
  cluster add-ons land unless told otherwise. Making stage that pool (the
  obvious choice, since it's not tainted) means konnectivity-agent,
  metrics-server and CoreDNS all run on stage nodes - and then prod's
  deny-from-stage NSG rule cuts them off from reaching prod node/pod IPs,
  breaking `kubectl logs`/`exec` and metrics for anything in prod. The
  system pool sidesteps this by living outside both tiers' subnets, so
  neither tier's NSG rules apply to it.
- **The cluster uses a user-assigned identity** (`<aks_cluster_name>-identity`).
  AKS KMS doesn't work with a system-assigned one, and this lets the Key
  Vault and VNet grants exist before the cluster is created, so
  `enable_secrets_encryption` works on the first apply. Changing an
  existing cluster from system-assigned to user-assigned is an in-place
  update, but plan it carefully on a live cluster.
- Flow logs target the VNet. Azure no longer allows new NSG flow logs, so
  an environment that still has the old per-NSG flow logs in state will
  see them destroyed and replaced by one VNet flow log on the next apply.
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
| `aks_public_ssh_key` | `string` | required | Public SSH key content for AKS nodes, not a file path |
| `aks_admin_group_object_ids` | `list(string)` | `[]` | Entra ID group object IDs granted AKS cluster-admin via native Azure RBAC for Kubernetes |
| `private_cluster_enabled` | `bool` | `true` | Private-only API server. See Notes |
| `api_server_authorized_ip_ranges` | `list(string)` | `[]` | Empty leaves the public endpoint open to any address. See Notes |
| `local_account_disabled` | `bool` | `false` | Disable the local admin account. See Notes |
| `service_cidr` | `string` | required | |
| `pod_cidr` | `string` | required | CIDR for pod IPs under Azure CNI Overlay. Must not overlap `vnet_address_space` or `service_cidr` |
| `enable_network_policy` | `bool` | `true` | Run on Azure CNI Powered by Cilium so NetworkPolicy objects are enforced. Enabling it on an existing cluster reimages every node |
| `log_analytics_workspace_id` | `string` | `null` | Resource ID of an existing Log Analytics Workspace for AKS's `oms_agent`. Null disables Container Insights. This module does not create one |
| `dns_service_ip` | `string` | required | Must be inside `service_cidr` |
| `system_subnet_address_prefix` | `string` | required | CIDR for the dedicated system pool's subnet - outside both tiers' subnets/NSG rules. Can be small (e.g. `/27`), since overlay mode means it only needs to cover node IPs |
| `system_node_vm_size` | `string` | required | |
| `system_availability_zones` | `list(number)` | `[1]` | |
| `system_node_min_count` | `number` | `1` | |
| `system_node_max_count` | `number` | `2` | |
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
| `enable_jump_vm` | `bool` | `false` | VM reachable only through Bastion. Requires `enable_bastion`. See Notes |
| `jump_vm_subnet_address_prefix` | `string` | `null` | `/29` or larger. Required when `enable_jump_vm` |
| `jump_vm_size` | `string` | `"Standard_B2s"` | |
| `jump_vm_access` | `map(object)` | `{}` | Entra ID groups allowed through Bastion to the jump VM. See Notes |
| `deploy_identities` | `map(object({ namespace, service_account_name }))` | `{}` | Per-env Workload Identity Federation identities for pipeline pods. See Notes above |
| `deploy_identity_role_assignments` | `list(object({ identity_key, role_definition_name, scope }))` | `[]` | Azure RBAC role assignments granting each deploy identity access to its real deployment target - a list since one identity may need more than one role/scope |
| `enable_secrets_encryption` | `bool` | `false` | Enables AKS's etcd secrets encryption via a Key Vault + key. See Notes above |
| `log_retention_in_days` | `number` | `90` | |
| `enable_vpc_flow_logs` | `bool` | `false` | Whether to create a VNet flow log for this module's VNet |
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
| `system_subnet_id` | |
| `stage_subnet_id` | |
| `prod_subnet_id` | |
| `bastion_host_id` | `null` unless `enable_bastion` |
| `jump_vm_id` | `--target-resource-id` for `az network bastion ssh`. `null` unless `enable_jump_vm` |
| `deploy_identity_client_ids` | Client ID per `deploy_identities` entry. Annotate the matching ServiceAccount with `azure.workload.identity/client-id: <this value>` |
| `workflow_controller_artifacts_client_id` | `null` unless `enable_artifact_archiving`. The pod also needs the `azure.workload.identity/use: "true"` label for AKS's webhook to inject the token |
| `artifact_storage_account_name` | `null` unless `enable_artifact_archiving` |

## Example

```hcl
module "cluster" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-Data-Plane/cluster?ref=v1.0.0"

  resource_group_name = "rg-asgardeo-argo-azure-dataplane"
  location             = "eastus"

  vnet_name          = "vnet-aks-argo-azure-dataplane"
  vnet_address_space = "10.2.0.0/16"

  aks_cluster_name = "aks-argo-azure-dataplane"
  aks_dns_prefix   = "aks-argo-azure-dataplane"

  kubernetes_version = "1.34"
  service_cidr        = "10.100.0.0/16"
  pod_cidr              = "10.244.0.0/16"
  dns_service_ip       = "10.100.0.10"

  log_analytics_workspace_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.OperationalInsights/workspaces/..."
  aks_public_ssh_key          = file("~/.ssh/id_rsa.pub")
  aks_admin_group_object_ids  = ["00000000-0000-0000-0000-000000000000"]

  system_subnet_address_prefix = "10.2.3.0/27"
  system_node_vm_size          = "Standard_D2s_v5"

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
