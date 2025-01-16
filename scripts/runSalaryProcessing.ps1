# PowerShell script to execute the Salary Processing Application 
# Path to the compiled C# application 
$applicationPath = "SalaryProcessingApp/bin/Debug/net6.0/SalaryProcessingApp.dll" 
# Path to the input CSV file 
$inputFilePath = "EmployeeData.csv" 
# Check if the application and input file exist 
if (-Not (Test-Path $applicationPath)) { 
    Write-Host "Error: Application not found at $applicationPath" 
    exit 1 
} 
if (-Not (Test-Path $inputFilePath)) { 
    Write-Host "Error: Input file not found at $inputFilePath" 
    exit 1 
} 
# Run the C# application with the input file as an argument 
Write-Host "Starting the Salary Processing Application..." 
try { 
    dotnet $applicationPath $inputFilePath 
    Write-Host "Salary Processing Completed." 
} catch { 
    Write-Host "An error occurred while executing the Salary Processing Application." 
    Write-Host "Error Details: $_" 
    exit 1 
}