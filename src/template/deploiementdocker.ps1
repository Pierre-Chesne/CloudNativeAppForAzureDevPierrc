$suffixe=Read-host "Entrez le suffixe à utiliser" 

$rgname="cnadocker$suffixe-rg"
$registryname="cnaazureregistry$suffixe"
$loginserver="$registryname.azurecr.io"
$location="francecentral"
$planname="cnalnxplan$suffixe"
$webappnameinitcode="cnaappforazuredev$suffixe"
$identityname="cnadockeridentity$suffixe"
$sub="e4ff89e1-14eb-4ea4-83f7-8c9959675b6b"

$taginitcode="$loginserver/" + "$webappnameinitcode"+ ":latest"

#Build the image

docker build --pull -t $webappnameinitcode -f ..\WebAppUI\Dockerfile ..\
docker tag $webappnameinitcode $taginitcode

#Create the resources group
Write-Host "Create ressources group"
az group create --name $rgname --location $location --output none
#Create the registry
Write-Host "Create Registry"
az acr create --name $registryname --resource-group $rgname --sku Basic --admin-enabled true --output none

#push the container
#Get the registry credential
$passwordregistry=az acr credential show --resource-group $rgname --name $registryname --query passwords[0].value

Write-Host "Push the image"
docker login $loginserver --username $registryname --password $passwordregistry
docker push $taginitcode


Write-Host "Create the identity"
$identityclientid=az identity create -g $rgname -n $identityname -l $location --query clientId
# $identityclientid=$identityclientid.Substring(1).Substring(0,$identityclientid.Length-2)
$identityid=az identity show -n $identityname -g $rgname --query id

# $identityid=$identityid.Substring(1).Substring(0,$identityid.Length-2)

Write-Host "Get the Registry id for RBAC"
$scope=az acr show --name $registryname -g $rgname --query id


Write-Host "Create Service plan"
az appservice plan create -g $rgname -n $planname -l $location --is-linux --output none

Write-Host "Create Web app with assigned identity"
az webapp create -g $rgname -p $planname  -n $webappnameinitcode  --deployment-container-image-name $taginitcode --assign-identity $identityid --output none
$principalid=az webapp identity assign --resource-group $rgname --name $webappnameinitcode --query principalId 

az role assignment create --assignee $principalid --scope $scope --role "AcrPull" --output none

#container logging
#az webapp log config --name $webappnameinitcode  --resource-group $rgname --docker-container-logging filesystem
#log stream
#az webapp log tail --name $webappnameinitcode  --resource-group $rgname
#launch browser  
az webapp browse -g $rgname -n $webappnameinitcode 

#ssh (see dockerfile how to enable)
#https://appsvcwebappdocker.scm.azurewebsites.net/webssh/host

Read-host "Une fois l application testée, appuyez sur [ENTREE] pour supprimer le groupe de ressources"
  az group delete -n  $rgname


