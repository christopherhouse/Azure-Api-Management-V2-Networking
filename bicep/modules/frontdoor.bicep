// Module for deploying Azure Front Door with Private Link integration

param location string
param frontDoorName string
param apimName string
param apimPrivateDnsZoneName string
param wafPolicyId string // WAF policy resource ID
param vnetId string // Add a parameter for the VNet resource ID
param logAnalyticsWorkspaceId string // Add a parameter for the Log Analytics Workspace resource ID
param apimResourceId string // Add a parameter for the APIM resource ID

resource frontDoorProfile 'Microsoft.Cdn/profiles@2025-04-15' = {
  name: frontDoorName
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 60
  }
}

resource frontDoorDiagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${frontDoorName}-diagnostic'
  scope: frontDoorProfile
  properties: {
    workspaceId: logAnalyticsWorkspaceId
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
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

resource afdEndpoint 'Microsoft.Cdn/profiles/afdendpoints@2025-04-15' = {
  parent: frontDoorProfile
  name: '${frontDoorName}-endpoint'
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
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/status-0123456789abcdef'
      probeRequestType: 'GET'
      probeProtocol: 'Https'
      probeIntervalInSeconds: 100
    }
    sessionAffinityState: 'Disabled'
  }
}

resource origin 'Microsoft.Cdn/profiles/origingroups/origins@2025-04-15' = {
  parent: originGroup
  name: '${apimName}-origin'
  properties: {
    hostName: '${apimName}.azure-api.net'
    originHostHeader: '${apimName}.azure-api.net'
    httpPort: 80
    httpsPort: 443
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: apimResourceId // Use the passed APIM resource ID
      }
      groupId: 'Gateway'
      privateLinkLocation: location
      requestMessage: 'Approve me'
    }
    enforceCertificateNameCheck: true
  }
}

resource afdRoute 'Microsoft.Cdn/profiles/afdendpoints/routes@2025-04-15' = {
  parent: afdEndpoint
  name: 'default-route'
  properties: {
    cacheConfiguration: {
      compressionSettings: {
        isCompressionEnabled: true
        contentTypesToCompress: [
          'application/json'
          'text/html'
          'text/css'
          'text/javascript'
        ]
      }
      queryStringCachingBehavior: 'UseQueryString'
    }
    originGroup: {
      id: originGroup.id
    }
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'MatchRequest'
    linkToDefaultDomain: 'Enabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
  dependsOn: [
    origin
  ]
}

resource afdSecurityPolicy 'Microsoft.Cdn/profiles/securitypolicies@2025-04-15' = {
  parent: frontDoorProfile
  name: 'waf-security-policy'
  properties: {
    parameters: {
      wafPolicy: {
        id: wafPolicyId // Ensure this is correctly passed and formatted
      }
      type: 'WebApplicationFirewall'
      associations: [
        {
          domains: [
            {
              id: afdEndpoint.id
            }
          ]
          patternsToMatch: [
            '/*'
          ]
        }
      ]
    }
  }
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: apimPrivateDnsZoneName
  location: 'global'
  properties: {}
}

resource privateDnsZoneVnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZone
  name: 'vnet-link'
  location: 'global'
  properties: {
    virtualNetwork: {
      id: vnetId
    }
    registrationEnabled: false
  }
}
