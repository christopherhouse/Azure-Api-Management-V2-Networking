param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroup
)

# Generate a unique deployment name using the first section of a GUID
$DeploymentName = "main-" + (New-Guid).ToString().Split('-')[0]

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
