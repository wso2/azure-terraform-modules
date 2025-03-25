# WSO2 Azure Terraform Modules

## Overview

The `wso2/azure-terraform-modules` repository provides a set of Terraform modules to facilitate the deployment and management of WSO2 products and related infrastructure on Microsoft Azure. These modules simplify complex configurations, enabling efficient provisioning and management of Azure resources.

## Features

- **Modular Design**: Predefined Terraform modules to support various Azure services.
- **Extensibility**: Customizable modules that adapt to different use cases.
- **Best Practices**: Implemented with Azure and Terraform best practices for reliability and performance.

## Requirements

Before using these modules, ensure you have the following prerequisites:

- **Terraform**: Version 1.0 or above.
- **Azure CLI**: Installed and configured for your account.
- **Azure Subscription**: Access to an active Azure subscription.
- **Permissions**: Sufficient permissions to create resources in Azure.

## Modules

### Usage Example

```hcl
module "example" {
  source = "github.com/wso2/azure-terraform-modules//<module-name>"
  
  # Module-specific inputs
  name      = "example"
  location  = "East US"
  resource_group = "example-resource-group"
}
```

Refer to individual module for detailed usage and input/output variables.

## Installation

Clone this repository or download the required modules into your Terraform project:

```bash
git clone https://github.com/wso2/azure-terraform-modules.git
```

Add the required modules to your Terraform configuration and initialize the working directory:

```bash
terraform init
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a pull request.

## License

This project is licensed under the [Apache License 2.0](LICENSE).

## Support

If you encounter any issues, please create an issue in the [GitHub Issues](https://github.com/wso2/azure-terraform-modules/issues) section of the repository.

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs/)
- [Azure Documentation](https://docs.microsoft.com/en-us/azure/)
