using System;
using System.Linq;
using System.Collections.Generic;

namespace BatchMigration
{
    public static class ProgramBService
    {
        public static List<DepartmentSalary> Run(List<DepartmentSalary> departmentSalaries)
        {
            Console.WriteLine("Program B completed.");
            return departmentSalaries; // Simply pass the data to the next stage
        }
    }
}
