# Use the .NET SDK base image for building the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy all files and restore any dependencies
COPY . ./
RUN dotnet restore ./src/DotNetEd.CoreAdmin/DotNetEd.CoreAdmin.csproj

# Publish the application
RUN dotnet publish ./src/DotNetEd.CoreAdmin/DotNetEd.CoreAdmin.csproj -c Release -o out

# Use the .NET runtime base image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

# Specify the command to run the application
ENTRYPOINT ["dotnet", "DotNetEd.CoreAdmin.dll", "--server.urls", "http://*:8080"]
