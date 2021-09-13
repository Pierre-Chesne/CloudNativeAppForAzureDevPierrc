#!/bin/bash
#sed -i.bak 's/\r$//' deploiement.sh

rgname=$1
planname=$2
webappname=$3
location=$4
sub=$5
runtime="DOTNETCORE|3.1" 

  #call laz login



az account set --subscription $sub
 
echo  création du groupe de ressource : $rgname 
az group create -n $rgname -l $location
  
echo  création du service plan : $planname
az appservice plan create -g $rgname -n $planname  --is-linux -l $location

echo création de la webapp $webappname
az webapp create -g $rgname -p $planname -n $webappname -r $runtime