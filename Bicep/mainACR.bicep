targetScope = 'subscription'
param RgSiteName string
param ACRName string
param ACRSku string

resource RgSite 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: RgSiteName
  location: deployment().location
}

module ACRDeploy 'acr.bicep' = {
  name: 'ACRDeploy'
  scope: RgSite
  params: {
    ACRName: ACRName
    ACRSku: ACRSku
  }
}
