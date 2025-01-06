# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - yyyy-mm-dd

## [v2.0.0] - 2025-01-06

### Added

### Changed

- Onboard & Support AzureRM 4.x.x Modules

### Deprecated

### Removed

### Fixed

### Security

## [v1.0.0] - 2025-01-04

### Added

- Add module for Firewall NAT rule collection
- Add Modules for DNS Zone, DNS A Record, User Assigned Identity and Update AKS-Firewall module
- Add module for Postgre Sql server configuration
- Add VMSS-Linux module
- Add Azure internal LB module
- Add LB extension modules
- Add custom image builder modules
- Add VMSS extension module
- Add AAD Login extension for VMSS
- Add AAD Extension for Static IP VM module
- Add Azure Open AI Service module
- Add LOG abbreviation
- Add Agent Queue Module
- Add DevOps Elastic Pool Module
- Add DevOps Pipeline Authorization Module
- Add DNS NS Record Terraform Module
- Add NSG to allow HTTPS inbounds
- Introduce Automation Variable Boolean Module
- Introduce FD Custom HTTPS Configuration Module
- Introduce Front Door Module with AzAPI Provider
- Add Backend Pool Settings to Configure FrontDoor Timeouts
- Add Cost Anomaly Alert module
- Add AzApi module for Log Analytics Workspace Table
- Add Terraform modules for Azure API Management
- Add multi method api operation module
- Api policy fragment modules
- Add logic app workflow, http request trigger and http action modules
- Add module for Policy Resource Group Assignment and update module Policy Definition
- Add queue_status Configuration to Azure DevOps Build Definition Modules
- Add Automation WebHook Rotation Notification
- Add support to analytics storage for cosmos db account
- Add Alert Processing Rule to Suppress Resolved Alerts
- Add Synapse Workspace module
- Add DNS TXT Record Terraform Module
- Add CDN FrontDoor Terraform Modules
- Onboard Azure CDN FrontDoor Policy Terraform Modules
- Add Synapse Link Support

### Changed

- Refactorize resource names with a resource abbreviation followed
- Update route table name
- Add config for key_vault_secrets_provider for AKS Cluster
- Add output for key_vault_secrets_provider for AKS module
- Update postgres sql db name
- Update aks firewall nsg_rule_apgw_inbound
- Integrate workload identity
- Update Application Gateway Outputs
- Update LB rule module
- Add VM module with static IP configurations
- Update compute gallery role name
- Parameterize resource abbreviation for Alert module
- Rename resource property for module VMSS Linux
- Rename resource property for module Static IP VM
- Bump azurerm required version in azure open-ai service
- Update modules Azure-Security-Center-Setting, PostgreSQL-Flexible-Server and create generic module for Route-Table
- Update azure open ai service module to contain custom sub domain name
- Update postgres flexible server with high availability
- Output DNS Zone Name Servers
- Update Route Table module
- Update AI cognitive deployment to support multi models
- Add cognitive_deployment_name to the value map
- Output Service Endpoint Name in GitHub-Service-Endpoint
- Output AKS Internal LB Subnet Name
- Update Application Gateway to support mTLS functionalities
- Update name abbreviation for appi
- Update SSL profile configuration in Application Gateway
- Add Application Gateway SSL profile to ignore block
- Make deployment sku values configurable for all the deployments
- Add support for multiple custom rule match_conditions
- Add Workload Identity Federation Manual AzureRM Service Endpoint & Output User Assigned Identity Client ID
- Modify create mode variable into an optional variable in postgresql flexible server
- Change postgre sql server high availability standby availability zone variable to number
- Add HTTPS & FTPS Configurations for Function Apps
- Output Storage Account Web Host
- Update default value for subnet nsg abbreviation to "nsg"
- Update route_table_abbreviation default value for Bastion Internal
- Update Log Analytics Workspace module to create log analytics solution optionally
- Output Virtual Machine Name from Azure VM Modules
- Enable keyvault secret provider and rotation conditionally for AKS
- Update mssql server vulnerability assessment module with conditional assessment
- Update Security Center Subscription Pricing with optional Subplan
- Add variable to override storage_redundancy in azurerm_cosmosdb_account
- Update Azure Linux Function App configurations
- Allow network ACL bypass for Cosmos DB
- Add & Support Tags for Monitor-Scheduled-Query-Alert
- Update the AKS-Generic Module to support Terraform 3.x.x
- Update CDN Endpoint module
- Support Expiration Date for Key Vault Secrets

### Deprecated

- Update Monitor Scheduled Query Alert with Azure V2 api

### Removed

- Remove Private IP Configuration from Firewall Module
- Remove retentions for storage log archive from diagnostic settings module
- Remove standby availability zone variable from high availability optional block in postgre sql server module

### Fixed

- Parameterized subnet integration
- Add missing dependencies
- Parameterize module name abbreviations
- Fix variable name
- Add resource name abbreviation for route table module
- Add lifecycle ignore for identity block
- Add abbreviation for Route Table module
- Add Route Table Association Dependency to AKS Firewall
- Configure Name Abbreviations of AMPLS Resources
- Output MSSQL Elastic Pool Name
- Fix output for static site custom domain
- Update AKS Firewall module to add key_vault_secrets_provider metablock only if enabled
- Add Abbreviation Support for Federated Identity Module
- Fix for variable mapping for Monitor-Activity-Log-Administrative-Alerts Module
- Output Automation WebHook Expiry Time
- Fix syntax error in Synapse workspace module
- Refactor synapse workspace module
