param(
    [Parameter(Mandatory=$false)]
    [string]$sub="9a96981c-4056-48b7-9301-7c2757548bcf",
    [Parameter(Mandatory=$false)]
    [string]$rgname="cnastep0-rg",
    [Parameter(Mandatory=$false)]
    [string]$planname="cnastep0-plan",    
    [Parameter(Mandatory=$false)]
    [string]$webappname="cnastep0",
    [Parameter(Mandatory=$false)]
    [string]$location="francecentral",
    [Parameter(Mandatory=$false)]
    [string]$branch="initicode",
    [Parameter(Mandatory=$false)]
    [string]$token="96702461874c862944f9046ceea6f9c1eaf6d689"
    

)

$gitrepo="https://github.com/EricVernie/CloudNativeAppForAzureDev.git"
az account set --subscription $sub
 
Write-Host creation du groupe de ressource : $rgname
  az group create -n $rgname -l $location

  write-host  Creation du service plan : $planname
  az appservice plan create -g $rgname -n $planname -l $location  --number-of-workers 2 --sku S1 


  write-host  Creation de la webapp $webappname  
  az webapp create -g $rgname -p $planname -n $webappname 

  # write-host  Publier le code from github
  # write-host deploiement de l application
  # az webapp deployment source config --name $webappname --resource-group $rgname --repo-url $gitrepo --branch $branch --git-token $token

  

