## Construire une image
a partir du repertoire ./src
docker pull mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim

 docker build -f .\WebAppUI\Dockerfile -t cnappforazuredev:dev  .

## Créer ou Run un container
 docker run -dt -e "ASPNETCORE_ENVIRONMENT=Development" -e "ASPNETCORE_URLS=https://+:443;http://+:80" -P --name CnAppForAzureDevOwn --entrypoint tail cnappforazuredev:dev 


docker exec -i -e ASPNETCORE_HTTPS_PORT="32780" -w "/app" 2cee56887494 sh -c "'dotnet' --additionalProbingPath /root/.nuget/fallbackpackages  '/app/bin/Debug/netcoreapp3.1/CnAppForAzureDev.dll\' | tee /dev/console"

##rentrer dans le container
docker exec -it 2cee56887494 /bin/bash



VS 
docker run -dt -v "C:\Users\ericv_pw09elh\vsdbg\vs2017u5:/remote_debugger:rw" -v "C:\CloudNativeAppForAzureDev\src\WebAppUI:/app" -v "C:\CloudNativeAppForAzureDev\src:/src/" -v "C:\Users\ericv_pw09elh\AppData\Roaming\Microsoft\UserSecrets:/root/.microsoft/usersecrets:ro" -v "C:\Users\ericv_pw09elh\AppData\Roaming\ASP.NET\Https:/root/.aspnet/https:ro" -v "C:\Users\ericv_pw09elh\.nuget\packages\:/root/.nuget/fallbackpackages" -e "DOTNET_USE_POLLING_FILE_WATCHER=1" -e "ASPNETCORE_LOGGING__CONSOLE__DISABLECOLORS=true" -e "ASPNETCORE_ENVIRONMENT=Development" -e "ASPNETCORE_URLS=https://+:443;http://+:80" -e "NUGET_PACKAGES=/root/.nuget/fallbackpackages" -e "NUGET_FALLBACK_PACKAGES=/root/.nuget/fallbackpackages" -P --name CnAppForAzureDev --entrypoint tail cnappforazuredev:dev -f /dev/null 


docker exec -i -e ASPNETCORE_HTTPS_PORT="32780" -w "/app" 6dd57c78d938 sh -c "dotnet --additionalProbingPath /root/.nuget/fallbackpackages  /app/bin/Debug/netcoreapp3.1/CnAppForAzureDev.dll | tee /dev/console"





experimental
docker run -dt -v "C:\CloudNativeAppForAzureDev\src\WebAppUI:/app" -v "C:\CloudNativeAppForAzureDev\src:/src/" -v "C:\Users\ericv_pw09elh\AppData\Roaming\ASP.NET\Https:/root/.aspnet/https:ro" -v "C:\Users\ericv_pw09elh\.nuget\packages\:/root/.nuget/fallbackpackages" -e "DOTNET_USE_POLLING_FILE_WATCHER=1" -e "ASPNETCORE_LOGGING__CONSOLE__DISABLECOLORS=true" -e "ASPNETCORE_ENVIRONMENT=Development" -e "ASPNETCORE_URLS=https://+:443;http://+:80" -e "NUGET_PACKAGES=/root/.nuget/fallbackpackages" -e "NUGET_FALLBACK_PACKAGES=/root/.nuget/fallbackpackages" -P --name CnAppForAzureDevExp --entrypoint tail cnappforazuredev:dev -f /dev/null 
