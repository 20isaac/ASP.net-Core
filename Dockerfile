# Use the .NET SDK base image for building the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the .csproj file and restore any dependencies
COPY ASP.net-Core/src/DotNetEd.CoreAdmin/*.csproj ./  
RUN dotnet restore

# Copy everything else and build the application
COPY ASP.net-Core/src/DotNetEd.CoreAdmin/. ./          
RUN dotnet publish -c Release -o out

# Use the .NET runtime base image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

# Specify the command to run the application
ENTRYPOINT ["dotnet", "DotNetEd.CoreAdmin.dll"]
