#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
#WORKDIR /app
EXPOSE 80
 #EXPOSE 443
#FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
# WORKDIR /src
# COPY ["WebAppUI/CnAppForAzureDev.csproj", "WebAppUI/"]
# RUN dotnet restore "WebAppUI/CnAppForAzureDev.csproj"
# COPY . .
# WORKDIR "/src/WebAppUI"
# RUN dotnet build "CnAppForAzureDev.csproj" -c Release -o /app/build

# FROM build AS publish
#RUN dotnet publish "CnAppForAzureDev.csproj" -c Release -o /app/publish

COPY /WebAppUI/publish /app


FROM base AS final
WORKDIR /app
#COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CnAppForAzureDev.dll"]