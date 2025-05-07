// Module for deploying APIM v2 Standard with VNet integration

param location string
param apimName string
param vnetName string
param subnetName string
param publisherName string
param publisherEmail string

resource apim 'Microsoft.ApiManagement/service@2024-06-01-preview' = {
  name: apimName
  location: location
  sku: {
    name: 'Standard'
    capacity: 1
  }
  properties: {
    virtualNetworkType: 'External'
    virtualNetworkConfiguration: {
      subnetResourceId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
    }
    publisherName: publisherName
    publisherEmail: publisherEmail
  }
}
