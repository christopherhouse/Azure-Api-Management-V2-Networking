param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroup
)

# Generate a unique 8-character alphanumeric string for the deployment name
$DeploymentName = "deploy-" + (-join ((65..90) + (97..122) + (48..57) | Get-Random -Count 8 | ForEach-Object { [char]$_ }))

# Display the deployment name
Write-Host "Deployment Name: $DeploymentName"

# Define the paths to the Bicep files
$BicepFile = "c:\Projects\Azure-Api-Management-v2-Networking\bicep\main.bicep"
$ParamsFile = "c:\Projects\Azure-Api-Management-v2-Networking\bicep\main.bicepparam"

# Run the deployment
az deployment group create `
    --resource-group $ResourceGroup `
    --name $DeploymentName `
    --template-file $BicepFile `
    --parameters $ParamsFile

Write-Host "Deployment completed with name: $DeploymentName"
