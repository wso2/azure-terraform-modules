# Argo-AKS-DataPlane/apps

Installs the Kubernetes-level workload an Azure Argo data plane runs.
Mirrors `Argo-EKS-DataPlane/apps` almost exactly: same generic Helm
release set, same `manifest_files`/`kubectl_manifest_files` pattern for
caller-supplied project-specific YAML. It assumes the caller has already
configured the `kubernetes`/`helm`/`kubectl` providers against the
cluster built by the sibling [`../cluster`](../cluster) module.

The one structural difference from the AWS side: External Secrets
Operator's controller pod needs no identity annotation here at all.
Workload Identity auth happens per-`ClusterSecretStore`, via
`serviceAccountRef` pointing at one of the federated ServiceAccounts this
module creates (`federated_service_accounts`) - not via an annotation on
ESO's own controller.

## What it provisions

- Per-tier namespaces (`namespaces`) plus the shared `system_namespace`
  and (if enabled) `argocd_namespace`.
- Helm releases for `argo-workflows` and `argo-events` (both in
  `system_namespace`), optionally `argocd`, optionally `external-secrets`.
- ServiceAccounts (`federated_service_accounts`) annotated with
  `azure.workload.identity/client-id` and labeled
  `azure.workload.identity/use: "true"`. This is the identity a
  `ClusterSecretStore`'s `serviceAccountRef` (or any other
  Workload-Identity-authenticated workload) presents, trusted via the
  cluster's own AKS OIDC issuer. `client_id` should come from the
  `cluster` module's `deploy_identity_client_ids` output.
- Arbitrary caller-supplied manifests via `manifest_files` (plain, via the
  `alekc/kubectl` provider - not `kubernetes_manifest`, which fails under
  AKS's `kubelogin`-based exec auth) and `kubectl_manifest_files` (for
  anything backed by a CRD installed in the same apply, e.g. ESO's
  `ClusterSecretStore`/`ExternalSecret`).
- Optional local files under `<module_path>/.rendered/` for inspecting
  rendered manifest content - never applied to the cluster.

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `namespaces` | `list(string)` | required | Per-tier Kubernetes namespaces, created by this module. Argo Workflows/Events themselves install once, cluster-wide, in `system_namespace` |
| `system_namespace` | `string` | `"argo"` | |
| `argo_workflows_chart_version` | `string` | `null` | |
| `argo_events_chart_version` | `string` | `null` | |
| `argo_helm_repo` | `string` | `"https://argoproj.github.io/argo-helm"` | |
| `argo_workflows_values` | `list(string)` | `[]` | Set `controller.workflowNamespaces` to `namespaces` (or leave cluster-wide) depending on how narrow you want the watch |
| `argo_events_values` | `list(string)` | `[]` | |
| `install_argocd` | `bool` | `true` | |
| `argocd_namespace` | `string` | `"argocd"` | |
| `argocd_chart_version` | `string` | `null` | |
| `argocd_helm_repo` | `string` | `"https://argoproj.github.io/argo-helm"` | |
| `argocd_values` | `list(string)` | `[]` | |
| `manifest_files` | `list(object({ location, content, template_map, namespace }))` | `[]` | Additional manifests applied after the Helm releases - debug-access RBAC, EventSource/Sensor definitions, ArgoCD Application/AppProject objects, ExternalSecrets/ClusterSecretStore for Workload Identity |
| `install_external_secrets` | `bool` | `true` | |
| `eso_chart_version` | `string` | `null` | |
| `eso_helm_repo` | `string` | `"https://charts.external-secrets.io"` | |
| `eso_namespace` | `string` | `"external-secrets"` | |
| `federated_service_accounts` | `map(object({ namespace, client_id, name = optional(string) }))` | `{}` | ServiceAccounts to create, each annotated with `azure.workload.identity/client-id`. `name` defaults to the map key when unset - needed because a pipeline's own WorkflowTemplate may hardcode a fixed `serviceAccountName` that must be identical across every namespace it runs in, while map keys must stay unique |
| `kubectl_manifest_files` | `list(object({ location, content, template_map, namespace }))` | `[]` | Manifests applied via the `alekc/kubectl` provider - required for anything backed by a CRD installed in this same apply |
| `rendered_manifest_files` | `map(object({ file_name, content }))` | `{}` | Writes each entry's content to `<module_path>/.rendered/<file_name>`, for inspection only |

## Outputs

None.

## Example

```hcl
module "apps" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-AKS-DataPlane/apps?ref=v1.0.0"

  namespaces = ["argo-azure-stage", "argo-azure-prod"]

  argo_workflows_values = [<<-EOT
    controller:
      serviceAccount:
        annotations:
          azure.workload.identity/client-id: ${module.cluster.workflow_controller_artifacts_client_id}
      podLabels:
        azure.workload.identity/use: "true"
    artifactRepository:
      archiveLogs: true
      azure:
        endpoint: https://${module.cluster.artifact_storage_account_name}.blob.core.windows.net
        container: argo-logs
        useSDKCreds: true
  EOT
  ]

  install_external_secrets = true

  federated_service_accounts = {
    "asgardeo-is-deploy-sa" = {
      namespace = "argo-azure-stage"
      client_id = module.cluster.deploy_identity_client_ids["is-deploy-stage"]
    }
  }

  depends_on = [module.cluster]
}
```
