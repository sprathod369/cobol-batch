using System;

namespace BatchMigration
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Batch Process Starting...");
 
            string inputFilePath = "data/EmployeeData.csv";

            try
            {
                // Step 1: Program A
                Console.WriteLine("Executing Program A...");
                var departmentSalaries = ProgramAService.Run(inputFilePath);

                // Step 2: Program B
                Console.WriteLine("Executing Program B...");
                var processedSalaries = ProgramBService.Run(departmentSalaries);

                // Step 3: Program C
                Console.WriteLine("Executing Program C...");
                ProgramCService.Run(processedSalaries);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error during batch process: {ex.Message}");
            }

            Console.WriteLine("Batch Process Completed.");
        }
    }
}
