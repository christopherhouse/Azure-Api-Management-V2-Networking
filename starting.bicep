@secure()
param users_1_lastName string
param profiles_afd_apimv2_afd_name string = 'afd-apimv2-afd'
param service_apim_apimv2_afd_name string = 'apim-apimv2-afd'
param virtualNetworks_vn_apimv2_afd_name string = 'vn-apimv2-afd'
param virtualNetworks_vn_apimv2_afd_addressSpace array = [
  '10.0.0.0/16'
]
param virtualNetworks_vn_apimv2_afd_subnetConfigurations array = [
  {
    name: 'private-endpoints'
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: null
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  {
    name: 'apim-out'
    addressPrefix: '10.0.1.0/24'
    networkSecurityGroup: null
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
]
param privateEndpoints_apim_apimv2_afd_pe_name string = 'apim-apimv2-afd-pe'
param workspaces_log_apimv2_afd_name string = 'log-apimv2-afd'
param networkSecurityGroups_nsg_apimv2_afd_apim_name string = 'nsg-apimv2-afd-apim'
param privateDnsZones_privatelink_azure_api_net_name string = 'privatelink.azure-api.net'
param frontdoorwebapplicationfirewallpolicies_wafpolv2_name string = 'wafpolv2'

resource profiles_afd_apimv2_afd_name_resource 'Microsoft.Cdn/profiles@2025-04-15' = {
  name: profiles_afd_apimv2_afd_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  kind: 'frontdoor'
  properties: {
    originResponseTimeoutSeconds: 60
  }
}

resource frontdoorwebapplicationfirewallpolicies_wafpolv2_name_resource 'Microsoft.Network/frontdoorwebapplicationfirewallpolicies@2024-02-01' = {
  name: frontdoorwebapplicationfirewallpolicies_wafpolv2_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: 'Detection'
      requestBodyCheck: 'Enabled'
      javascriptChallengeExpirationInMinutes: 30
    }
    customRules: {
      rules: []
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_DefaultRuleSet'
          ruleSetVersion: '2.1'
          ruleSetAction: 'Block'
          ruleGroupOverrides: []
          exclusions: []
        }
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
          ruleGroupOverrides: []
          exclusions: []
        }
      ]
    }
  }
}

resource networkSecurityGroups_nsg_apimv2_afd_apim_name_resource 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: networkSecurityGroups_nsg_apimv2_afd_apim_name
  location: 'eastus2'
  properties: {
    securityRules: []
  }
}

resource privateDnsZones_privatelink_azure_api_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_azure_api_net_name
  location: 'global'
  properties: {}
}

resource workspaces_log_apimv2_afd_name_resource 'Microsoft.OperationalInsights/workspaces@2025-02-01' = {
  name: workspaces_log_apimv2_afd_name
  location: 'eastus2'
  properties: {
    sku: {
      name: 'pergb2018'
    }
    retentionInDays: 30
    features: {
      legacy: 0
      searchVersion: 1
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: json('-1')
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource service_apim_apimv2_afd_name_resource 'Microsoft.ApiManagement/service@2024-06-01-preview' = {
  name: service_apim_apimv2_afd_name
  location: 'East US 2'
  sku: {
    name: 'StandardV2'
    capacity: 1
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publisherEmail: 'apis@contoso.net'
    publisherName: 'Contoso'
    notificationSenderEmail: 'apimgmt-noreply@mail.windowsazure.com'
    hostnameConfigurations: [
      {
        type: 'Proxy'
        hostName: '${service_apim_apimv2_afd_name}.azure-api.net'
        negotiateClientCertificate: false
        defaultSslBinding: true
        certificateSource: 'BuiltIn'
      }
    ]
    virtualNetworkConfiguration: {
      subnetResourceId: virtualNetworks_vn_apimv2_afd_name_apim_out.id
    }
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Protocols.Server.Http2': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168': 'False'
    }
    virtualNetworkType: 'External'
    natGatewayState: 'Enabled'
    apiVersionConstraint: {}
    publicNetworkAccess: 'Disabled'
    privateEndpointConnections: [
      {
        id: service_apim_apimv2_afd_name_service_apim_apimv2_afd_name_pe.id
        name: '${service_apim_apimv2_afd_name}-pe'
        type: 'Microsoft.ApiManagement/service/privateEndpointConnections'
        properties: {
          privateEndpoint: {}
          privateLinkServiceConnectionState: {
            status: 'Approved'
          }
        }
      }
      {
        id: service_apim_apimv2_afd_name_edbc57da_c84c_47c5_b8d8_09ff37c801f8.id
        name: 'edbc57da-c84c-47c5-b8d8-09ff37c801f8'
        type: 'Microsoft.ApiManagement/service/privateEndpointConnections'
        properties: {
          privateEndpoint: {}
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Approve me'
          }
        }
      }
    ]
    legacyPortalStatus: 'Disabled'
    developerPortalStatus: 'Disabled'
    releaseChannel: 'Default'
  }
}



resource service_apim_apimv2_afd_name_service_apim_apimv2_afd_name_pe 'Microsoft.ApiManagement/service/privateEndpointConnections@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/${service_apim_apimv2_afd_name}-pe'
  properties: {
    privateLinkServiceConnectionState: {
      status: 'Approved'
    }
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_edbc57da_c84c_47c5_b8d8_09ff37c801f8 'Microsoft.ApiManagement/service/privateEndpointConnections@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/edbc57da-c84c-47c5-b8d8-09ff37c801f8'
  properties: {
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Approve me'
    }
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}
resource profiles_afd_apimv2_afd_name_apim_ep 'Microsoft.Cdn/profiles/afdendpoints@2025-04-15' = {
  parent: profiles_afd_apimv2_afd_name_resource
  name: 'apim-ep'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

resource profiles_afd_apimv2_afd_name_default_origin_group 'Microsoft.Cdn/profiles/origingroups@2025-04-15' = {
  parent: profiles_afd_apimv2_afd_name_resource
  name: 'default-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 100
    }
    sessionAffinityState: 'Disabled'
  }
}

resource privateEndpoints_apim_apimv2_afd_pe_name_resource 'Microsoft.Network/privateEndpoints@2024-05-01' = {
  name: privateEndpoints_apim_apimv2_afd_pe_name
  location: 'eastus2'
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_apim_apimv2_afd_pe_name
        id: '${privateEndpoints_apim_apimv2_afd_pe_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_apim_apimv2_afd_pe_name}'
        properties: {
          privateLinkServiceId: service_apim_apimv2_afd_name_resource.id
          groupIds: [
            'Gateway'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: '${privateEndpoints_apim_apimv2_afd_pe_name}-nic'
    subnet: {
      id: virtualNetworks_vn_apimv2_afd_name_private_endpoints.id
    }
    ipConfigurations: []
    customDnsConfigs: []
  }
}

resource privateEndpoints_apim_apimv2_afd_pe_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-05-01' = {
  name: '${privateEndpoints_apim_apimv2_afd_pe_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-azure-api-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_azure_api_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_apim_apimv2_afd_pe_name_resource
  ]
}

resource profiles_afd_apimv2_afd_name_apim_ep_default_route 'Microsoft.Cdn/profiles/afdendpoints/routes@2025-04-15' = {
  parent: profiles_afd_apimv2_afd_name_apim_ep
  name: 'default-route'
  properties: {
    cacheConfiguration: {
      compressionSettings: {
        isCompressionEnabled: true
        contentTypesToCompress: [
          'application/eot'
          'application/font'
          'application/font-sfnt'
          'application/javascript'
          'application/json'
          'application/opentype'
          'application/otf'
          'application/pkcs7-mime'
          'application/truetype'
          'application/ttf'
          'application/vnd.ms-fontobject'
          'application/xhtml+xml'
          'application/xml'
          'application/xml+rss'
          'application/x-font-opentype'
          'application/x-font-truetype'
          'application/x-font-ttf'
          'application/x-httpd-cgi'
          'application/x-javascript'
          'application/x-mpegurl'
          'application/x-opentype'
          'application/x-otf'
          'application/x-perl'
          'application/x-ttf'
          'font/eot'
          'font/ttf'
          'font/otf'
          'font/opentype'
          'image/svg+xml'
          'text/css'
          'text/csv'
          'text/html'
          'text/javascript'
          'text/js'
          'text/plain'
          'text/richtext'
          'text/tab-separated-values'
          'text/xml'
          'text/x-script'
          'text/x-component'
          'text/x-java-source'
        ]
      }
      queryStringCachingBehavior: 'UseQueryString'
    }
    customDomains: []
    originGroup: {
      id: profiles_afd_apimv2_afd_name_default_origin_group.id
    }
    ruleSets: []
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
    profiles_afd_apimv2_afd_name_resource
  ]
}

resource profiles_afd_apimv2_afd_name_default_origin_group_default_origin 'Microsoft.Cdn/profiles/origingroups/origins@2025-04-15' = {
  parent: profiles_afd_apimv2_afd_name_default_origin_group
  name: 'default-origin'
  properties: {
    hostName: 'apim-apimv2-afd.azure-api.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'apim-apimv2-afd.azure-api.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: service_apim_apimv2_afd_name_resource.id
      }
      groupId: 'Gateway'
      privateLinkLocation: 'eastus2'
      requestMessage: 'Approve me'
    }
    enforceCertificateNameCheck: true
  }
  dependsOn: [
    profiles_afd_apimv2_afd_name_resource
  ]
}

resource profiles_afd_apimv2_afd_name_wafpolv2_11416ecb 'Microsoft.Cdn/profiles/securitypolicies@2025-04-15' = {
  parent: profiles_afd_apimv2_afd_name_resource
  name: 'wafpolv2-11416ecb'
  properties: {
    parameters: {
      wafPolicy: {
        id: frontdoorwebapplicationfirewallpolicies_wafpolv2_name_resource.id
      }
      type: 'WebApplicationFirewall'
      associations: [
        {
          domains: [
            {
              id: profiles_afd_apimv2_afd_name_apim_ep.id
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
