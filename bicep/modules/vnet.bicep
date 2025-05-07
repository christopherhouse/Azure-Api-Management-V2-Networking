param location string
param vnetName string
param vnetAddressSpace array
param subnetConfigurations array

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: vnetAddressSpace
    }
    subnets: [
      for subnet in subnetConfigurations: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.addressPrefix
          networkSecurityGroup: subnet.nsgName != null ? {
            id: resourceId('Microsoft.Network/networkSecurityGroups', subnet.nsgName)
          } : null
          privateEndpointNetworkPolicies: subnet.privateEndpointNetworkPolicies
          privateLinkServiceNetworkPolicies: subnet.privateLinkServiceNetworkPolicies
          delegations: subnet.delegation != null ? [
            {
              name: '${subnet.name}-delegation'
              properties: {
                serviceName: subnet.delegation
              }
            }
          ] : null
        }
      }
    ]
  }
}
