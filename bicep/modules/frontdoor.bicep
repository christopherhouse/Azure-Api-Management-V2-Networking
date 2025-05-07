// Module for deploying Azure Front Door with Private Link integration

param location string
param frontDoorName string
param apimName string
param apimPrivateEndpointName string
param apimPrivateDnsZoneName string

resource frontDoorProfile 'Microsoft.Cdn/profiles@2025-04-15' = {
  name: frontDoorName
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor' // Updated to match starting.bicep
  }
  properties: {
    originResponseTimeoutSeconds: 60
  }
}

resource afdEndpoint 'Microsoft.Cdn/profiles/afdendpoints@2025-04-15' = {
  parent: frontDoorProfile
  name: 'apim-ep'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

resource originGroup 'Microsoft.Cdn/profiles/origingroups@2025-04-15' = {
  parent: frontDoorProfile
  name: 'default-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
    }
    healthProbeSettings: {
      probePath: '/status'
      probeProtocol: 'Https'
      probeIntervalInSeconds: 120
    }
  }
}

resource origin 'Microsoft.Cdn/profiles/origingroups/origins@2025-04-15' = {
  parent: originGroup
  name: 'apim-origin'
  properties: {
    hostName: '${apimName}.azure-api.net'
    privateLinkResource: {
      id: resourceId('Microsoft.Network/privateEndpoints', apimPrivateEndpointName)
    }
    privateLinkLocation: location
    privateLinkApprovalMessage: 'Please approve this connection for APIM integration.'
  }
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: apimPrivateDnsZoneName
  location: 'global'
  properties: {}
}
