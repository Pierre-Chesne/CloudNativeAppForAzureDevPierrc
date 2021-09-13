param appPlanName string
param skuPlan string

resource appPlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appPlanName
  location: resourceGroup().location
  kind: 'linux'
  sku: {
    name: skuPlan
  }
  properties: {
    reserved: true
  }
}

output appPlanId string = appPlan.id
