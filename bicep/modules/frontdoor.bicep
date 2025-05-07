// Module for deploying Azure Front Door with Private Link integration

param location string
param frontDoorName string

resource frontDoor 'Microsoft.Cdn/profiles@2025-04-15' = {
  name: frontDoorName
  location: location
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
  properties: {
    enabledState: 'Enabled'
    // Add additional configurations for Front Door as needed
  }
}
