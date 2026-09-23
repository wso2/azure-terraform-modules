# Argo-Control-Plane (azuread)

Provisions everything the Argo control plane's Entra ID SSO needs,
self-contained in one module: the app registration, its service principal
with an auto-rotating password, and the 4 RBAC tier groups the control
plane's credential-injector component maps incoming requests against
(nonprod reader/contributor, prod reader/contributor).

This is what fronts the control plane's portal (argo-server/oauth2-proxy)
with Entra ID login. It's unrelated to any per-cloud data-plane identity
(IRSA/Workload Identity), which the `aws`/`azurerm` modules handle
instead.

Raw `azuread_*`/`time_rotating` resource blocks, instead of composing the
generic Application-Registration/Service-Principal/
Service-Principal-Password/Group modules separately - a caller only needs
this one module block. No `cluster`/`apps` split; this is a single-file
module with no sub-directories.

## What it provisions

- An `azuread_application_registration` (the Entra ID app registration
  itself), with `group_membership_claims` controlling whether/how the
  groups claim is issued.
- Optionally, `azuread_application_redirect_uris` for that app.
- An `azuread_service_principal` for the app registration.
- A rotating password for that service principal
  (`azuread_service_principal_password`, rotated via `time_rotating` on
  the schedule set by `sp_password_rotation_months`).
- Four `azuread_group` resources (the RBAC tier groups:
  `<group_name_prefix>-nonprod-reader`, `-nonprod-contributor`,
  `-prod-contributor`, `-prod-reader`), each a security-enabled group with
  a fixed description.

## Notes

- Whether `azuread_application_redirect_uris` gets created is controlled
  by the plain bool `manage_redirect_uris`, not by whether `redirect_uris`
  is non-empty. `count`/`for_each` can't depend on a value that's only
  known after apply, such as a LoadBalancer hostname, and `redirect_uris`
  itself may be one of those.
- **If the RBAC tier groups or app registration already exist** - e.g.
  created manually before this module was adopted - import them before
  the first `apply`. A fresh apply against existing display names creates
  duplicate groups with new object IDs, disconnected from any existing
  user memberships or downstream group-ID lookups:

  ```bash
  terraform import 'module.argo_sso.azuread_group.tier["nonprod-reader"]' <existing-object-id>
  ```
- **No apply-order dependency on the cluster modules.** This module has no
  Terraform relationship to the AWS `Argo-Control-Plane` cluster or either
  data plane - it only needs to exist before someone tries to log into the
  control plane's portal, so it can be applied at any point relative to
  them, commonly alongside the AWS `Argo-Control-Plane` module.

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `application_name` | `string` | `"argo-rnd-portal"` | Display name for the Entra ID app registration |
| `group_membership_claims` | `list(string)` | `["SecurityGroup"]` | Configures the groups claim issued in a token this app expects. One or more of: `None`, `SecurityGroup`, `DirectoryRole`, `ApplicationGroup`, `All` |
| `manage_redirect_uris` | `bool` | `false` | Whether to create the `azuread_application_redirect_uris` resource at all. See Notes above |
| `redirect_uris` | `list(string)` | `[]` | Redirect URIs to assign to the application. Only used when `manage_redirect_uris = true` |
| `redirect_uri_type` | `string` | `"Web"` | One of: `PublicClient`, `SPA`, `Web` |
| `sp_app_role_assignment_required` | `bool` | `false` | Whether the service principal requires an app role assignment to a user or group before Entra ID will issue a token to the application |
| `sp_password_display_name` | `string` | `null` | Display name for the service principal's rotating password |
| `sp_password_rotation_months` | `number` | `6` | How often the service principal password rotates |
| `group_name_prefix` | `string` | `"grp-asgardeo-argo"` | Prefix for the 4 RBAC tier group display names (e.g. produces `grp-asgardeo-argo-nonprod-reader`) |

## Outputs

| Name | Description |
|---|---|
| `application_id` | |
| `client_id` | |
| `object_id` | |
| `sp_internal_id` | |
| `sp_password` | Sensitive |
| `tier_group_ids` | Object ID per tier - keys: `nonprod-reader`, `nonprod-contributor`, `prod-contributor`, `prod-reader` |

## Example

```hcl
provider "azuread" {
  tenant_id = var.entra_tenant_id
}

module "argo_sso" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azuread/Argo-Control-Plane?ref=v1.0.0"

  application_name        = "argo-rnd-portal"
  group_membership_claims = ["SecurityGroup"]

  manage_redirect_uris = true
  redirect_uris         = ["https://portal.example.com/oauth2/callback"]

  sp_password_display_name    = "argo-rnd-portal-sso"
  sp_password_rotation_months = 6
  group_name_prefix           = "grp-asgardeo-argo"
}
```
