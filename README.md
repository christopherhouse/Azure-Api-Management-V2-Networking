# 🌐 Azure API Management v2 Networking with Front Door Integration

Welcome to the **Azure API Management v2 Networking** repository! This project is designed to deploy and configure a robust API Management (APIM) solution integrated with Azure Front Door, Virtual Networks (VNet), and other essential Azure services. 🚀

---

## 📋 Overview

This repository contains Bicep templates to deploy the following Azure resources:

- **API Management (APIM)**: Configured with VNet integration and developer portal status toggle.
- **Azure Front Door**: Integrated with APIM for global load balancing and private link.
- **Virtual Network (VNet)**: Configured with subnets and network security groups (NSGs).
- **Web Application Firewall (WAF)**: Protects your APIs with managed and custom rules.
- **Log Analytics Workspace**: Centralized logging and monitoring for all resources.

---

## 🛠️ Deployment Architecture

Below is a high-level architecture diagram of the deployed solution:

![Architecture Diagram](https://via.placeholder.com/800x400?text=Architecture+Diagram)

---

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

To successfully deploy the solution, the following parameters are required:

| Parameter Name            | Description                                                                 | Example Value                  |
|---------------------------|-----------------------------------------------------------------------------|--------------------------------|
| `location`                | Azure region for resource deployment                                       | `eastus2`                     |
| `apimName`                | Name of the API Management instance                                        | `my-apim-instance`            |
| `vnetName`                | Name of the Virtual Network                                                | `my-vnet`                     |
| `subnetName`              | Name of the subnet for APIM                                                | `apim-subnet`                 |
| `vnetAddressSpace`        | Address space for the Virtual Network                                      | `['10.0.0.0/16']`             |
| `subnetConfigurations`    | Subnet configurations for the VNet                                         | See `main.bicepparam`         |
| `nsgName`                 | Name of the Network Security Group                                         | `my-nsg`                      |
| `frontDoorName`           | Name of the Azure Front Door instance                                      | `my-frontdoor`                |
| `publisherName`           | Publisher name for APIM                                                   | `Default Publisher`           |
| `publisherEmail`          | Publisher email for APIM                                                  | `publisher@example.com`       |
| `logAnalyticsWorkspaceName` | Name of the Log Analytics Workspace                                      | `my-log-analytics`            |
| `wafPolicyName`           | Name of the Web Application Firewall policy                                | `my-waf-policy`               |
| `apimPublicNetworkAccess` | Public network access setting for APIM (`Enabled` or `Disabled`)           | `Disabled`                    |
| `developerPortalStatus`   | Developer portal status for APIM (`Enabled` or `Disabled`)                 | `Enabled`                     |

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

## 📖 Example Parameters File

Below is an example `main.bicepparam` file:

```bicep-params
param location = 'eastus2'
param apimName = 'my-apim-instance'
param vnetName = 'my-vnet'
param subnetName = 'apim-subnet'
param vnetAddressSpace = [
  '10.0.0.0/16'
]
param subnetConfigurations = [
  {
    name: 'apim-subnet'
    addressPrefix: '10.0.1.0/24'
    nsgName: 'my-nsg'
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    delegation: null
  }
]
param nsgName = 'my-nsg'
param frontDoorName = 'my-frontdoor'
param publisherName = 'Default Publisher'
param publisherEmail = 'publisher@example.com'
param logAnalyticsWorkspaceName = 'my-log-analytics'
param wafPolicyName = 'my-waf-policy'
param apimPublicNetworkAccess = 'Disabled'
param developerPortalStatus = 'Enabled'
```

---

## 🛡️ Security Best Practices

- Use [Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/) to store sensitive information.
- Enable diagnostic settings for all resources to monitor and log activities.
- Regularly review and update your WAF rules to protect against new threats.

---

## 📞 Support

For any issues or questions, please open an issue in this repository or contact your Azure administrator.

---