using System;
using System.Linq;

namespace BatchMigration
{
    public static class ProgramAService
    {
        public static void Run(string inputFilePath, string outputFilePath)
        {
            var employees = CsvHelper.ReadCsv<Employee>(inputFilePath);

            var departmentSalaries = employees
                .GroupBy(e => e.Department)
                .Select(g => new DepartmentSalary
                {
                    Department = g.Key,
                    TotalSalary = g.Sum(e => e.Salary)
                }).ToList();

            CsvHelper.WriteCsv(departmentSalaries, outputFilePath);
            Console.WriteLine("Program A completed. Output written to " + outputFilePath);
        }
    }
}
