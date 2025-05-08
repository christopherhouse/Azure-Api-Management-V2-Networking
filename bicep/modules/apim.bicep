// Module for deploying APIM v2 Standard with VNet integration

param location string
param apimName string
param subnetResourceId string
param publisherName string
param publisherEmail string
param logAnalyticsWorkspaceId string
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

resource apim 'Microsoft.ApiManagement/service@2024-06-01-preview' = {
  name: apimName
  location: location
  sku: {
    name: 'StandardV2'
    capacity: 1
  }
  properties: {
    publisherName: publisherName
    publisherEmail: publisherEmail
    virtualNetworkConfiguration: {
      subnetResourceId: subnetResourceId
    }
    virtualNetworkType: 'External'
    natGatewayState: 'Enabled'
    apiVersionConstraint: {
      minApiVersion: '2021-08-01'
    }
    publicNetworkAccess: apimPublicNetworkAccess
    developerPortalStatus: developerPortalStatus
  }
}

resource apimDiagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'logs-and-metrics'
  scope: apim
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logAnalyticsDestinationType: 'Dedicated'
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        categoryGroup: 'audit'
        enabled: true
      }
      {
        categoryGroup: 'allLogs'
        enabled: true
      }
    ]
  }
}

output id string = apim.id

