targetScope =  'subscription'
param RgSiteName string
param appPlanName string
param skuPlan string
param siteName string
param ACRRegistryName string
param ACRRegistryUser string
param ACRRegistryPWD string
param ImageName string
param ImageVersion string 


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

module WebAppDeploy 'WebApp.bicep' = {
  name: 'WebAppDeploy'
  scope: RgSite
  params: {
    siteName: siteName
    ACRRegistryName: ACRRegistryName
    ACRRegistryUser: ACRRegistryUser
    ACRRegistryPWD: ACRRegistryPWD 
    ImageName: ImageName
    ImageVersion: ImageVersion
    appPlanId: AppPlanDeploy.outputs.appPlanId       
  }  
}
