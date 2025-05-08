// Parameters file for main.bicep

using 'main.bicep'

param location = 'eastus2'
param apimName = 'cmh-apim-v2-network-part-iv'
param vnetName = 'cmh-apim-v2-vnet'
param subnetName = 'apim-out'
param vnetAddressSpace = [
  '10.0.0.0/16'
]
param subnetConfigurations = [
  {
    name: 'private-endpoints'
    addressPrefix: '10.0.0.0/24'
    nsgName: null
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    delegation: null
  }
  {
    name: 'apim-out'
    addressPrefix: '10.0.1.0/24'
    nsgName: nsgName
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    delegation: 'Microsoft.Web/serverFarms'
  }
]
param nsgName = 'nsg-apim-out'
param frontDoorName = 'cmh-apim-v2-frontdoor'
param publisherName = 'Default Publisher'
param publisherEmail = 'publisher@example.com'
param logAnalyticsWorkspaceName = 'cmh-log-analytics'
param wafPolicyName = 'wafPolicy'
param apimPublicNetworkAccess = 'Enabled'
param developerPortalStatus = 'Enabled'
