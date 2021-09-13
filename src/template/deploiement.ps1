Set-Location ..\WebAppUI\
dotnet publish -o .\publish
Set-Location ..\Template\
dotnet .\ZipPublishFile.dll ..\WebAppUI\publish\ .\WebAppUI.zip



$sub="9a96981c-4056-48b7-9301-7c2757548bcf"
$suffixe=Read-host "Entrez le suffixe à utiliser" 

$rgname="cna"+ $suffixe +"-rg"
$planname="cnaplan"+$suffixe
$webappname="cnawebui"+$suffixe
$location="francecentral"



####################################################################################

#az login
az account set --subscription $sub
############################## GROUPE DE RESSOURCE #################################
write-host  Creation du groupe de ressource : $rgname 
az group create -n $rgname -l $location
####################################################################################

########################## SERVICE PLAN ET APP SERVICE ###########################
write-host  Creation du service plan : $planname
az appservice plan create -g $rgname -n $planname -l $location --sku B1

write-host Creation de la Web App
az webapp create -g $rgname -p $planname -n $webappname 

az webapp config appsettings set -g $rgname -n $webappname --settings  CatalogItemsServiceUrl=$catalogserviceurl  MaxItemsOnHomePage=6 ApplicationInsightsAgent_EXTENSION_VERSION="~2" 

write-host Deploiement de la Web App
az webapp deployment source config-zip -g $rgname -n $webappname --src .\WebAppUI.zip --subscription $sub


az webapp stop -g $rgname -n $webappname
az webapp start -g $rgname -n $webappname
