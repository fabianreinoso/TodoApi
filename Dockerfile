FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /webapi

EXPOSE 80
EXPOSE 7100

#COPY 

COPY ./*.csproj ./
RUN dotnet restore

#COPY todo

COPY . . 
RUN dotnet publish -c Release -o out 

#BUILD 
FROM mcr.microsoft.com/dotnet/sdk:8.0
WORKDIR /webapi
COPY --from=build /webapi/out .
ENTRYPOINT [ "dotnet" , "TodoApi.dll"]