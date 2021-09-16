param siteName string
param ACRRegistryName string
param ACRRegistryUser string
param ACRRegistryPWD string
param ImageName string
param ImageVersion string
param appPlanId string

resource siteAppAPI 'Microsoft.Web/sites@2020-06-01' = {
  name: siteName
  location: resourceGroup().location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: ACRRegistryName
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ACRRegistryUser
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ACRRegistryPWD
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }

      ]
      linuxFxVersion:'DOCKER|${ImageName}:${ImageVersion}'             
    }
    serverFarmId: appPlanId
  }  
}
