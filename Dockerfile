# Use the official .NET SDK image as a build environment 
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env 
WORKDIR /app 
# Copy the project files and restore dependencies 
COPY *.csproj ./ 
RUN dotnet restore 
# Copy the rest of the application code and build the release 
COPY . ./ 
RUN dotnet publish -c Release -o out 
# Use the official ASP.NET Core runtime image 
FROM mcr.microsoft.com/dotnet/aspnet:6.0 
WORKDIR /app 
COPY --from=build-env /app/out . 
# Expose the port the app runs on 
EXPOSE 80 
# Set the entry point for the container 
ENTRYPOINT ["dotnet", "SalaryProcessingApp.dll"] # Use the official .NET SDK image as a build environment 
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env 
WORKDIR /app 
# Copy the project files and restore dependencies 
COPY *.csproj ./ 
RUN dotnet restore 
# Copy the rest of the application code and build the release 
COPY . ./ 
RUN dotnet publish -c Release -o out 
# Use the official ASP.NET Core runtime image 
FROM mcr.microsoft.com/dotnet/aspnet:6.0 
WORKDIR /app 
COPY --from=build-env /app/out . 
# Expose the port the app runs on 
EXPOSE 80 
# Set the entry point for the container 
ENTRYPOINT ["dotnet", "SalaryProcessingApp.dll"] # Use the official .NET runtime as a parent image 
FROM mcr.microsoft.com/dotnet/aspnet:6.0 
# Set the working directory inside the container 
WORKDIR /app 
# Copy the application files into the container 
COPY SalaryProcessingApp/bin/Debug/net6.0/ . 
# Expose the port the app runs on 
EXPOSE 80 
# Run the application 
ENTRYPOINT ["dotnet", "SalaryProcessingApp.dll"] 