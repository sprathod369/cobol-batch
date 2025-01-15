using System;
using System.Linq;

namespace BatchMigration
{
    public static class ProgramCService
    {
        public static void Run(string inputFilePath)
        {
            var departmentSalaries = CsvHelper.ReadCsv<DepartmentSalary>(inputFilePath);

            decimal totalSalary = departmentSalaries.Sum(d => d.TotalSalary);
            Console.WriteLine("Total Salary: " + totalSalary);
        }
    }
}
