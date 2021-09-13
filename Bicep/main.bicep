targetScope = 'subscription'
param RgSiteName string

resource RgSite 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: RgSiteName
  location: deployment().location
}
