// Main Bicep file for deploying APIM v2 Standard with VNet and Azure Front Door Private Link integration

param location string = resourceGroup().location
param apimName string
param vnetName string
param subnetName string
param frontDoorName string
param publisherName string
param publisherEmail string
param vnetAddressSpace string[]
param subnetConfigurations array
param nsgName string
param logAnalyticsWorkspaceName string
param wafPolicyName string
@allowed([
  'Enabled'
  'Disabled'
])
param apimPublicNetworkAccess string

@allowed([
  'Enabled'
  'Disabled'
])
param developerPortalStatus string

module nsgModule 'modules/nsg.bicep' = {
  name: 'nsg-${deployment().name}'
  params: {
    location: location
    nsgName: nsgName
    logAnalyticsWorkspaceId: logAnalyticsWorkspaceModule.outputs.workspaceId // Pass the Log Analytics Workspace resource ID
  }
}

module vnetModule 'modules/vnet.bicep' = {
  name: 'vnet-${deployment().name}'
  params: {
    location: location
    vnetName: vnetName
    vnetAddressSpace: vnetAddressSpace
    subnetConfigurations: subnetConfigurations
  }
  dependsOn: [
    nsgModule
  ]
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' existing = {
  parent: vnet
  name: subnetName
}

module logAnalyticsWorkspaceModule 'modules/logAnalyticsWorkspace.bicep' = {
  name: 'log-${deployment().name}'
  params: {
    location: location
    workspaceName: logAnalyticsWorkspaceName
  }
}

module apimModule 'modules/apim.bicep' = {
  name: 'apim-${deployment().name}'
  params: {
    location: location
    apimName: apimName
    subnetResourceId: subnet.id
    publisherName: publisherName
    publisherEmail: publisherEmail
    logAnalyticsWorkspaceId: logAnalyticsWorkspaceModule.outputs.workspaceId
    apimPublicNetworkAccess: apimPublicNetworkAccess
    developerPortalStatus: developerPortalStatus
  }
  dependsOn: [
    vnetModule
  ]
}

module wafPolicyModule 'modules/wafPolicy.bicep' = {
  name: 'waf-${deployment().name}'
  params: {
    location: location
    wafPolicyName: wafPolicyName
  }
}

module frontDoorModule 'modules/frontdoor.bicep' = {
  name: 'afd-${deployment().name}'
  params: {
    location: location
    frontDoorName: frontDoorName
    apimName: apimName
    apimPrivateDnsZoneName: 'privatelink.azure-api.net'
    wafPolicyId: wafPolicyModule.outputs.wafPolicyId
    vnetId: vnet.id
    logAnalyticsWorkspaceId: logAnalyticsWorkspaceModule.outputs.workspaceId
    apimResourceId: apimModule.outputs.id // Update to use the new output property name
  }
}
