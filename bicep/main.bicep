// Main Bicep file for deploying APIM v2 Standard with VNet and Azure Front Door Private Link integration

param location string = resourceGroup().location
param apimName string
param vnetName string
param subnetName string
param frontDoorName string
param publisherName string
param publisherEmail string

module apimModule 'modules/apim.bicep' = {
  name: 'apimDeployment'
  params: {
    location: location
    apimName: apimName
    vnetName: vnetName
    subnetName: subnetName
    publisherName: publisherName
    publisherEmail: publisherEmail
  }
}

module frontDoorModule 'modules/frontdoor.bicep' = {
  name: 'frontDoorDeployment'
  params: {
    location: location
    frontDoorName: frontDoorName
    apimName: apimName
    apimPrivateEndpointName: '${apimName}-pe'
    apimPrivateDnsZoneName: 'privatelink.azure-api.net'
  }
}
