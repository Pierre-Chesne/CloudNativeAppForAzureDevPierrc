targetScope = 'subscription'
param RgSiteName string
param appPlanName string
param skuPlan string


resource RgSite 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: RgSiteName
  location: deployment().location
}

module AppPlanDeploy 'AppPlan.bicep' = {
  name: 'AppPlanDeploy'
  scope: RgSite
  params: {
    appPlanName: appPlanName
    skuPlan: skuPlan
  }
}
