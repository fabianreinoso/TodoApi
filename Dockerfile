# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /webapi
EXPOSE 80
EXPOSE 7100

# Copy the project file and restore the dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code and build
COPY . ./
RUN dotnet publish -c Release -o out

# Stage 2: Create the final image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /webapi
EXPOSE 80
EXPOSE 7100

# Copy the published application to the final image
COPY --from=build /webapi/out .

# Set the entry point to start the application
ENTRYPOINT ["dotnet", "TodoApi.dll"]
