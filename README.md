# 🌐 Azure API Management v2 Networking with Front Door Integration

Welcome to the **Azure API Management v2 Networking** repository! This project is designed to deploy and configure API Management Standard v2 with all public access routed through Azure Front Door and vnet integrated for egress. 🚀

---

## 📋 Overview

This repository contains Bicep templates to deploy the following Azure resources:

- **API Management (APIM)**: Configured with VNet integration and developer portal status toggle.
- **Azure Front Door**: Integrated with APIM for global load balancing and private link.
- **Virtual Network (VNet)**: Configured with subnets and network security groups (NSGs).
- **Web Application Firewall (WAF)**: Protects your APIs with managed and custom rules.
- **Log Analytics Workspace**: Centralized logging and monitoring for all resources.

## 📦 Repository Structure

```plaintext
.
├── deploy.ps1                     # PowerShell script to deploy the solution
├── bicep/
│   ├── main.bicep                 # Main Bicep file
│   ├── main.bicepparam            # Parameters file for main.bicep
│   ├── modules/
│   │   ├── apim.bicep             # APIM module
│   │   ├── frontdoor.bicep        # Front Door module
│   │   ├── logAnalyticsWorkspace.bicep # Log Analytics Workspace module
│   │   ├── nsg.bicep              # Network Security Group module
│   │   ├── vnet.bicep             # Virtual Network module
│   │   ├── wafPolicy.bicep        # WAF Policy module
```

---

## ⚙️ Parameters

The following table describes the parameters for `main.bicep`:

| Parameter Name            | Default Value       | Allowed Values          | Required | Data Type   | Description                                                                 |
|---------------------------|---------------------|--------------------------|----------|-------------|-----------------------------------------------------------------------------|
| `location`                | `resourceGroup().location` | N/A                  | Yes      | `string`    | Azure region for resource deployment                                       |
| `apimName`                | N/A                 | N/A                      | Yes      | `string`    | Name of the API Management instance                                        |
| `vnetName`                | N/A                 | N/A                      | Yes      | `string`    | Name of the Virtual Network                                                |
| `subnetName`              | N/A                 | N/A                      | Yes      | `string`    | Name of the subnet for APIM                                                |
| `vnetAddressSpace`        | N/A                 | N/A                      | Yes      | `string[]`  | Array of address prefixes for the Virtual Network                          |
| `subnetConfigurations`    | N/A                 | N/A                      | Yes      | `array`     | Subnet configurations for the VNet                                         |
| `nsgName`                 | N/A                 | N/A                      | Yes      | `string`    | Name of the Network Security Group                                         |
| `frontDoorName`           | N/A                 | N/A                      | Yes      | `string`    | Name of the Azure Front Door instance                                      |
| `publisherName`           | N/A                 | N/A                      | Yes      | `string`    | Publisher name for APIM                                                   |
| `publisherEmail`          | N/A                 | N/A                      | Yes      | `string`    | Publisher email for APIM                                                  |
| `logAnalyticsWorkspaceName` | N/A               | N/A                      | Yes      | `string`    | Name of the Log Analytics Workspace                                        |
| `wafPolicyName`           | N/A                 | N/A                      | Yes      | `string`    | Name of the Web Application Firewall policy                                |
| `apimPublicNetworkAccess` | `Disabled`          | `Enabled`, `Disabled`    | Yes      | `string`    | Public network access setting for APIM                                     |
| `developerPortalStatus`   | `Enabled`           | `Enabled`, `Disabled`    | Yes      | `string`    | Developer portal status for APIM                                           |

---

## 🚀 Deployment Instructions

### Prerequisites

1. Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
2. Install the [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install).
3. Ensure you have the necessary permissions to deploy resources in your Azure subscription.

### Deployment Steps

#### Using PowerShell

Run the following command to deploy the solution:

```powershell
.\deploy.ps1 -ResourceGroup <YourResourceGroupName>
```

#### Using Azure CLI

Run the following commands to deploy the solution:

```bash
az deployment group create \
    --resource-group <YourResourceGroupName> \
    --template-file bicep/main.bicep \
    --parameters @bicep/main.bicepparam
```

---

## Security Best Practices

- Use [Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/) to store sensitive information.
- Enable diagnostic settings for all resources to monitor and log activities.
- Regularly review and update your WAF rules to protect against new threats.

---