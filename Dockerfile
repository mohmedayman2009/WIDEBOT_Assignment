# Use the official ASP.NET image as a base image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

# Use the SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["YourApp.csproj", "./"]
RUN dotnet restore "./YourApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "YourApp.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "YourApp.csproj" -c Release -o /app/publish

# Build runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "YourApp.dll"]
