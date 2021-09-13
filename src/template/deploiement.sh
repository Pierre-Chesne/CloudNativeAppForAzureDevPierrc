#!/bin/bash
#sed -i.bak 's/\r$//' deploiement.sh
echo "Entrez le nom du groupe de ressources "
read rgname
 sub=e4ff89e1-14eb-4ea4-83f7-8c9959675b6b 
 planname=ncainitcode
 webappname=ncainitcodewebapp 
 location=francecentral 

  #call laz login


#  az account set --subscription $sub
 
echo  création du groupe de ressource : $rgname 
az group create -n $rgname -l $location

echo  se positionner dans le répertoire ou se trouve le code 

  cd ../WebAppUI
  
echo création de la webapp $webappname   + publication de l application

az webapp up -g $rgname -p $planname -n $webappname -l $location

echo Une fois l application testée, appuyez sur [ENTREE] pour supprimer le groupe de ressource
read 
az group delete -g  $rgname