using System;
using System.Linq;
using System.Collections.Generic;

namespace BatchMigration
{
    public static class ProgramAService
    {
        public static List<DepartmentSalary> Run(string inputFilePath)
        {
            var employees = CsvHelper.ReadCsv<Employee>(inputFilePath);

            var departmentSalaries = employees
                .GroupBy(e => e.Department)
                .Select(g => new DepartmentSalary
                {
                    Department = g.Key,
                    TotalSalary = g.Sum(e => e.Salary)
                }).ToList();

            Console.WriteLine("Program A completed.");
            return departmentSalaries; // Return the result in-memory
        }
    }
}
