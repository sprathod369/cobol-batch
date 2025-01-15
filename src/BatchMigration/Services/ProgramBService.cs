using System;
using System.Linq;

namespace BatchMigration
{
    public static class ProgramBService
    {
        public static void Run(string inputFilePath, string outputFilePath)
        {
            var departmentSalaries = CsvHelper.ReadCsv<DepartmentSalary>(inputFilePath);
            CsvHelper.WriteCsv(departmentSalaries, outputFilePath);
            Console.WriteLine("Program B completed. Output written to " + outputFilePath);
        }
    }
}
