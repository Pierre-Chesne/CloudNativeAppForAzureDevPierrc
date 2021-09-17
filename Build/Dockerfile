FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base

EXPOSE 80

COPY /Build/publish /app

FROM base AS final

WORKDIR /app

ENTRYPOINT ["dotnet", "CnAppForAzureDev.dll"]