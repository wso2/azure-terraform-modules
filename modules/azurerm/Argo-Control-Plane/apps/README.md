# Argo-Control-Plane/apps (azurerm)

Installs the Kubernetes-level workload the Argo control plane runs: NATS
(the mTLS message bus every data plane dials into for dispatch), Argo
Workflows/Events (the dispatcher itself), cert-manager (bootstraps the NATS
client-CA and issues per-identity client certs), Traefik (the portal
gateway), and External Secrets Operator.

This is the Azure twin of the AWS `Argo-Control-Plane/apps` module. The
install is the same; only two things differ:

- ESO authenticates with **AKS Workload Identity** (`eso_client_id`)
  instead of an IRSA role ARN.
- No `StorageClass` is created. NATS JetStream PVCs use AKS's built-in
  default `managed-csi` class, where the AWS module has to create `gp3`.

This module assumes the caller has already configured the
`kubernetes`/`helm`/`kubectl` providers against the cluster built by the
sibling [`../cluster`](../cluster) module. It takes no cluster credentials
as input.

## What it provisions

- The primary namespace (`var.namespace`, default `"argo"`) plus any extra
  namespaces and ConfigMaps the caller supplies (e.g. oauth2-proxy,
  gateway, dispatch-tier namespaces).
- Per-identity SSH keypairs (`tls_private_key`) for the reverse-tunnel
  clients, and a `tunnel-server-authorized-keys` Secret built from them,
  if `tunnel_client_identities` is non-empty.
- cert-manager (opt-in via `install_cert_manager`) plus a self-signed
  bootstrap `Issuer`, a `nats-client-ca` `Certificate`/`ClusterIssuer`, a
  `nats-server-cert` `Certificate`, and one client `Certificate` per entry
  in `nats_client_identities`.
- Helm releases for `nats`, `argo-workflows`, `argo-events`, and (opt-in)
  `traefik` and `external-secrets`.
- Caller-supplied manifests via `manifest_files` and
  `kubectl_manifest_files` (the latter for CRD-backed objects such as
  ESO's `ClusterSecretStore`).

## Notes

- Every data plane reaches this NATS broker through its external
  LoadBalancer hostname. Add that hostname to
  `nats_server_external_dns_names`, or cross-cluster mTLS fails x509 SAN
  verification.
- ESO's controller ServiceAccount gets the
  `azure.workload.identity/client-id` annotation and its pod gets the
  `azure.workload.identity/use: "true"` label. Both are required; the
  label alone or the annotation alone silently falls back to no identity.
- Point the `ClusterSecretStore` at the cluster module's
  `eso_key_vault_uri` with `authType: WorkloadIdentity` and no
  `serviceAccountRef`, so it uses the controller's own identity:

  ```yaml
  apiVersion: external-secrets.io/v1
  kind: ClusterSecretStore
  metadata:
    name: control-plane-kv
  spec:
    provider:
      azurekv:
        authType: WorkloadIdentity
        vaultUrl: ${eso_key_vault_uri}
  ```
- `traefik_namespace` can also be listed in `extra_namespaces`; the
  Traefik release uses `create_namespace`, which tolerates that.
- If the gateway's backends are `ExternalName` Services, set
  `providers.kubernetesCRD.allowExternalNameServices: true` in
  `traefik_values`.
- `argo_workflows_values` should set `workflow-controller` `replicas>=2`
  with leader election; `nats_values` should set JetStream `replicas=3`
  with topology spread across zones and a PVC-backed store.

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `namespace` | `string` | `"argo"` | Namespace for the control plane's Argo Workflows + Argo Events release |
| `extra_namespaces` | `list(string)` | `[]` | Additional namespaces to create beyond `namespace` |
| `config_maps` | `map(object({ namespace, data }))` | `{}` | ConfigMaps created before `manifest_files`/`kubectl_manifest_files`. Map key is the ConfigMap name |
| `tunnel_client_identities` | `list(string)` | `[]` | One reverse-tunnel SSH keypair per data-plane identity. Private keys come back via `tunnel_client_private_keys` |
| `argo_workflows_chart_version` | `string` | `null` | |
| `argo_events_chart_version` | `string` | `null` | |
| `nats_chart_version` | `string` | `null` | |
| `argo_helm_repo` | `string` | `"https://argoproj.github.io/argo-helm"` | |
| `nats_helm_repo` | `string` | `"https://nats-io.github.io/k8s/helm/charts/"` | |
| `argo_workflows_values` | `list(string)` | `[]` | Helm values overrides (YAML strings, later entries win) |
| `argo_events_values` | `list(string)` | `[]` | Helm values overrides for argo-events |
| `nats_values` | `list(string)` | `[]` | Helm values overrides for the nats chart |
| `install_cert_manager` | `bool` | `true` | Installs cert-manager and bootstraps the NATS mTLS client-CA |
| `cert_manager_chart_version` | `string` | `null` | |
| `cert_manager_helm_repo` | `string` | `"https://charts.jetstack.io"` | |
| `cert_manager_namespace` | `string` | `"cert-manager"` | |
| `install_traefik` | `bool` | `true` | Installs the Traefik controller |
| `traefik_chart_version` | `string` | `null` | |
| `traefik_helm_repo` | `string` | `"https://traefik.github.io/charts"` | |
| `traefik_values` | `list(string)` | `[]` | Helm values overrides for traefik |
| `traefik_namespace` | `string` | `"gateway"` | |
| `nats_server_external_dns_names` | `list(string)` | `[]` | Extra `dnsNames` for `nats-server-cert`. See Notes |
| `nats_client_identities` | `list(string)` | `[]` | `commonName` per data-plane NATS client certificate, e.g. `["azure-stage", "aws-prod"]` |
| `manifest_files` | `list(object({ location, content, template_map }))` | `[]` | Additional manifests - dispatch RBAC, SSO gateway, LoadBalancer Services |
| `install_external_secrets` | `bool` | `true` | Installs External Secrets Operator |
| `eso_client_id` | `string` | `null` | Workload Identity client ID for ESO's controller ServiceAccount, from the `cluster` module's `eso_client_id` output. Required when `install_external_secrets` is true |
| `eso_chart_version` | `string` | `null` | |
| `eso_helm_repo` | `string` | `"https://charts.external-secrets.io"` | |
| `eso_namespace` | `string` | `"external-secrets"` | Must match the `cluster` module's `eso_namespace` |
| `kubectl_manifest_files` | `list(object({ location, content, template_map, namespace }))` | `[]` | Manifests backed by a CRD installed in this same apply |

## Outputs

Identical names to the AWS module, so a data plane consumes either cloud's
control plane the same way.

| Name | Description |
|---|---|
| `nats_client_cert_pems` | Map of identity to client cert PEM (sensitive) |
| `nats_client_key_pems` | Map of identity to client key PEM (sensitive) |
| `nats_client_ca_pems` | Map of identity to the client-CA cert PEM (sensitive) |
| `tunnel_client_private_keys` | OpenSSH private key per `tunnel_client_identities` entry (sensitive) |

## Example

```hcl
module "apps" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-Control-Plane/apps?ref=v1.0.0"

  namespace        = "argo"
  extra_namespaces = ["oauth2-proxy", "gateway"]

  nats_client_identities   = ["control-plane", "azure-stage", "azure-prod", "aws-stage", "aws-prod"]
  tunnel_client_identities = ["aws", "azure"]

  nats_values = [<<-EOT
    config:
      jetstream:
        enabled: true
    statefulSet:
      replicas: 3
  EOT
  ]

  install_external_secrets = true
  eso_client_id            = module.cluster.eso_client_id

  depends_on = [module.cluster]
}
```
