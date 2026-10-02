# Argo-Control-Plane (azurerm)

Provisions the Argo control plane on Azure. The control plane is the
single, cloud-agnostic hub that dispatches tasks to data planes over NATS
(mTLS) and waits for their results. It holds no cloud credentials and runs
no deploy workloads itself.

This is the Azure alternative to the AWS
[`Argo-Control-Plane`](https://github.com/wso2/aws-terraform-modules/tree/main/modules/aws/Argo-Control-Plane)
module. Use one or the other - there is only ever one control plane. Its
outputs use the same names as the AWS module's, so the data planes
(`Argo-AKS-DataPlane`, `Argo-EKS-DataPlane`) consume it the same way
whichever cloud it runs in.

Portal SSO is not part of this module. `modules/azuread/Argo-Entra-SSO`
provides it, and works unchanged in front of either cloud's control plane.

## Structure

- [`cluster/`](./cluster) - standalone module for the Azure infrastructure:
  AKS, VNet, NAT Gateway, Key Vaults (KMS and ESO), Workload Identities,
  optional Bastion. Nothing Kubernetes-level.
- [`apps/`](./apps) - standalone module for everything inside the cluster:
  NATS (JetStream, mTLS via cert-manager), Argo Workflows, Argo Events,
  cert-manager, Traefik, External Secrets Operator, and caller-supplied
  manifests.
- The top-level `main.tf`/`variables.tf`/`outputs.tf`/`versions.tf` are a
  thin composite wrapper: they call `cluster/`, configure the
  `kubernetes`/`helm`/`kubectl` providers against it, call `apps/`, and
  wire the two together.

So there are two ways to use this:

1. Call `cluster/` and `apps/` yourself and wire them by hand - more
   control.
2. Call this directory directly and get both already wired - less to
   write.

## Composite entrypoint

Every `cluster` and `apps` variable passes straight through, except
`eso_client_id`, which is wired automatically from
`module.cluster.eso_client_id`. `eso_namespace` feeds both submodules so
ESO's federated identity subject can't drift from where ESO is installed.

The providers authenticate with `kubelogin` in `azurecli` mode, the same
as `Argo-AKS-DataPlane`, so `kubelogin` and a logged-in `az` CLI are
required wherever this runs. The caller configures the `azurerm` provider
(including its `features {}` block) as usual.

## Notes

- **Two-step first apply.** The AKS cluster must exist before the
  `kubernetes`/`helm` providers can authenticate:
  `terraform apply -target=module.cluster`, then a plain
  `terraform apply`.
- **Secrets encryption is a third, follow-up apply.** Set
  `enable_secrets_encryption = true` only after the cluster exists - see
  [`cluster/README.md`](./cluster/README.md).
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

module "argo_control_plane" {
  source = "git::https://github.com/wso2/azure-terraform-modules.git//modules/azurerm/Argo-Control-Plane?ref=v1.0.0"

  # --- cluster ---
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

  # --- apps ---
  extra_namespaces = ["oauth2-proxy", "gateway"]

  nats_client_identities         = ["control-plane", "azure-stage", "azure-prod", "aws-stage", "aws-prod"]
  tunnel_client_identities       = ["aws", "azure"]
  nats_server_external_dns_names = ["nats.argo.example.com"]
}
```

See [`cluster/README.md`](./cluster/README.md) and
[`apps/README.md`](./apps/README.md) for each submodule's full inputs and
outputs.
