using System;

namespace BatchMigration
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Batch Process Starting...");

            string inputFilePath = "data/EmployeeData.csv";
            string outputFilePathA = "data/deptSalaryOutput.csv";
            string outputFilePathB = "data/salaryReport.csv";

            try
            {
                // Step 1: Program A
                Console.WriteLine("Executing Program A...");
                ProgramAService.Run(inputFilePath, outputFilePathA);

                // Step 2: Program B
                Console.WriteLine("Executing Program B...");
                ProgramBService.Run(outputFilePathA, outputFilePathB);

                // Step 3: Program C
                Console.WriteLine("Executing Program C...");
                ProgramCService.Run(outputFilePathB);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error during batch process: {ex.Message}");
            }

            Console.WriteLine("Batch Process Completed.");
        }
    }
}
