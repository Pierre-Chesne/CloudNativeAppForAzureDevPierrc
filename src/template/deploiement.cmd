echo %1

set sub= 9a96981c-4056-48b7-9301-7c2757548bcf
set /p rgname= Entrez le nom du groupe de ressources 
set planname=ncainitcode
set webappname=ncainitcodewebapp 
set location=francecentral 

rem call laz login

  call az account set --subscription %sub%
 
echo  création du groupe de ressource : %rgname% 
  call az group create -n %rgname% -l %location%

echo  se positionner dans le répertoire ou se trouve le code 

  cd ..\WebAppUI
  
echo  création de la webapp %webappname%   + publication de l'application  
rem call az webapp create -g %rgname% -p %planname% -n %webappnam% -l %location% 

call az webapp up -g %rgname% -p %planname% -n %webappname% -l %location% 

set /p nerienfaire= Une fois l'application testée, appuyez sur [ENTREE] pour supprimer le groupe de ressource

call az group delete -g  %rgname% 