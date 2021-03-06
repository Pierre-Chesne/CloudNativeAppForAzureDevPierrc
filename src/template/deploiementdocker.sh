#!/bin/bash
#sed -i.bak 's/\r$//' deploiementdocker.sh


echo Entrez le suffixe à utiliser
read suffixe

rgname="cnadocker$suffixe-rg"
registryname="cnaazureregistry$suffixe"
loginserver="$registryname.azurecr.io"
location="francecentral"
planname="cnalnxplan$suffixe"
webappnameinitcode="cnaappforazuredev$suffixe"
identityname="cnadockeridentity$suffixe"
sub="e4ff89e1-14eb-4ea4-83f7-8c9959675b6b"

taginitcode="$loginserver/$webappnameinitcode:latest"

#Build the image

docker build --pull -t $webappnameinitcode -f ../WebAppUI/Dockerfile ../
docker tag $webappnameinitcode $taginitcode

#Create the resources group
echo Create ressources group
az group create --name $rgname --location $location --output none

#Create the registry
echo Create Registry
az acr create --name $registryname --resource-group $rgname --sku Basic --admin-enabled true


#Get the registry credential
passwordregistry=`az acr credential show --resource-group $rgname --name $registryname --query passwords\[0\].value`

passwordregistry=(`awk -F\" '{ print $2 }' <<< $passwordregistry`)

#push the container
echo Push the image
docker login $loginserver --username $registryname --password $passwordregistry
docker push $taginitcode


echo Create the identity
identityclientid=`az identity create -g $rgname -n $identityname -l $location --query clientId`
identityclientid=(`awk -F\" '{ print $2 }' <<< $identityclientid`)

identityid=`az identity show -n $identityname -g $rgname --query id`
identityid=(`awk -F" '{ print $2 }' <<< $identityid`)

echo Get the Registry id for RBAC
scope=`az acr show --name $registryname -g $rgname --query id`
scope=(`awk -F\" '{ print $2 }' <<< $scope`)


echo Create Service plan
az appservice plan create -g $rgname -n $planname -l $location --is-linux

echo Create Web app with assigned identity
az webapp create -g $rgname -p $planname  -n $webappnameinitcode  --deployment-container-image-name $taginitcode --assign-identity $identityid 

echo Enable CD for the web app
cicdwebhook=`az webapp deployment container config --name $webappnameinitcode --resource-group $rgname --enable-cd true --query CI_CD_URL`
cicdwebhook=(`awk -F\" '{ print $2 }' <<< $cicdwebhook`)

echo Create webhook for the registry
az acr webhook create -g $rgname -l $location -n Webhookforinitcode -r $registryname --uri $cicdwebhook --actions push


principalid=`az webapp identity assign --resource-group $rgname --name $webappnameinitcode --query principalId`
principalid=(`awk -F\" '{ print $2 }' <<< $principalid`)


#az role assignment create --assignee $principalid --scope $scope --role "AcrPull"



#container logging
#az webapp log config --name $webappnameinitcode  --resource-group $rgname --docker-container-logging filesystem
#log stream
#az webapp log tail --name $webappnameinitcode  --resource-group $rgname
#launch browser  
#az webapp browse -g $rgname -n $webappnameinitcode 

#ssh (see dockerfile how to enable)
#https://appsvcwebappdocker.scm.azurewebsites.net/webssh/host