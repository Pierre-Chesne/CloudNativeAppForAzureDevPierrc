#  Déployer une application Cloud Native

Pour ce qui nous concerne, nous allons utiliser l'interface [Azure CLI](https://docs.microsoft.com/fr-fr/cli/azure/install-azure-cli?view=azure-cli-latest)

script [cmd](https://github.com/EricVernie/CloudNativeAppForAzureDev/blob/initcode/src/template/deploiement.cmd)
script [bash](https://github.com/EricVernie/CloudNativeAppForAzureDev/blob/initcode/src/template/deploiement.sh)

1. Connexion à Azure
        
        az login

1. Définir l'abonnement à utiliser

        az account set --subscription [abonnement]

1. Création d'un groupe de ressources.

        az group create -n [nom du groupe de ressources] -l "francecentral"

1. Création d'un Azure App Service Plan

        az appservice plan create -g [nom du groupe de ressources] -n [nom du plan]


1. Création et Déploiement de la Web App

        Cloner le code : git clone [chemin github]
        ce positionner dans le répertoire /src/webappui
        az webapp up -g ncainitcode-rg -p ncainitcodeplan -n ncainitcodewebapp

Alternative : 

1. Création des ressources à partir d'un modèle ARM

        az deployment group create --resource-group  [groupe de ressources]--template-file [".\src\template\initcode\template.json"]()

[Exemple de modèle ARM](https://github.com/EricVernie/CloudNativeAppForAzureDev/blob/initcode/src/template/initcode/template.json)


