# Use the .NET SDK image to build and run the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Restore dependencies and build the application
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Use the runtime image for a smaller final image
FROM mcr.microsoft.com/dotnet/runtime:6.0

# Set the working directory in the runtime container
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=build /app/out .

# Set the entry point for the container
ENTRYPOINT ["dotnet", "BatchMigration.dll"]
