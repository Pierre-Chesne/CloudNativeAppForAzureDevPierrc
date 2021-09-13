#!/bin/bash
#sed -i.bak 's/\r$//' actiondeploiementdocker.sh

suffixe=$1
dockerfilepath=$2
slnpath=$3

rgname="cnastep$suffixe-rg"
registryname="cnaacr$suffixe"
loginserver="$registryname.azurecr.io"
location="francecentral"
planname="cna$suffixe-plan"
webappnameinitcode="cnawebappui$suffixe"
identityname="cnaidentity$suffixe"
sub="9a96981c-4056-48b7-9301-7c2757548bcf"

taginitcode="$loginserver/$webappnameinitcode:latest"

#Build the image
echo "Build the docker image"
docker build --pull -t $webappnameinitcode -f  $2 $3
echo "Tag the docker image for push to Azure registry"
docker tag $webappnameinitcode $taginitcode

#Create the resources group
echo "Create ressource group $rgname"
az group create --name $rgname --location $location --output none

#Create the registry
echo "Create Registry $registryname"
az acr create --name $registryname --resource-group $rgname --sku Basic --admin-enabled true --output none


#Get the registry credential
echo "Get the registry password"
passwordregistry=`az acr credential show --resource-group $rgname --name $registryname --query passwords[0].value --output tsv`

#push the container
echo "Push the image to the $registryname registry"
docker login $loginserver --username $registryname --password $passwordregistry
docker push $taginitcode


echo "Create the identity $identityname"
identityclientid=`az identity create -g $rgname -n $identityname -l $location --query clientId`
identityclientid=(`awk -F\" '{ print $2 }' <<< $identityclientid`)

echo "Get the identityid"
identityid=`az identity show -n $identityname -g $rgname --query id`
identityid=(`awk -F\" '{ print $2 }' <<< $identityid`)

# echo "Get the Registry id for RBAC"
# scope=`az acr show --name $registryname -g $rgname --query id`
# scope=(`awk -F\" '{ print $2 }' <<< $scope`)

echo "Create Service plan $planname"
az appservice plan create -g $rgname -n $planname -l $location --is-linux  --number-of-workers 2 --sku S1 --output none

echo "Create Web app $webappnameinitcode with assigned identity"
az webapp create -g $rgname -p $planname  -n $webappnameinitcode  --deployment-container-image-name $taginitcode --assign-identity $identityid --output none

echo "Enable CD for the web app"
cicdwebhook=`az webapp deployment container config --name $webappnameinitcode --resource-group $rgname --enable-cd true --query CI_CD_URL --output tsv`


echo "Create webhook for the registry"
az acr webhook create -g $rgname -l $location -n Webhookforinitcode -r $registryname --uri $cicdwebhook --actions push --output none

#principalid=`az webapp identity assign --resource-group $rgname --name $webappnameinitcode --query principalId`
#principalid=(`awk -F\" '{ print $2 }' <<< $principalid`)

#az role assignment create --assignee $principalid --scope $scope --role "AcrPull"

#container logging
#az webapp log config --name $webappnameinitcode  --resource-group $rgname --docker-container-logging filesystem
#log stream
#az webapp log tail --name $webappnameinitcode  --resource-group $rgname
#launch browser  
#az webapp browse -g $rgname -n $webappnameinitcode 

#ssh (see dockerfile how to enable)
#https://appsvcwebappdocker.scm.azurewebsites.net/webssh/host
