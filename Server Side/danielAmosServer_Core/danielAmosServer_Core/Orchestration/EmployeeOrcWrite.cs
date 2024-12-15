using danielAmosServer_Core.BL;
using danielAmosServer_Core.Models;
using danielAmosServer_Core.OrchestrationInterfaces;

namespace danielAmosServer_Core.Orchestration
{
    /// <summary>
    /// The EmployeeOrcRead class responsible for Managing Write requests 
    /// From the EmployeeController (API) to the EmployeeBL (Business Logic).
    /// </summary>

    public class EmployeeOrcWrite : IEmployeeOrcWrite
    {
        private readonly EmployeeBL employeeBL;

        public EmployeeOrcWrite(EmployeeBL employeeBL)
        {
            // Calling and executing services of the BL (Business Logic).
            this.employeeBL = employeeBL;
        }

        public async Task<List<ManagerWithEmployee>> ManagerWithEmployeeInsert(ManagerWithEmployee managerWithEmployee)
        {
            return await employeeBL.ManagerWithEmployeeInsert(managerWithEmployee);
        }

        public async Task<List<Employee>> EmployeeInsert(Employee employee)
        {
            return await employeeBL.EmployeeInsert(employee);
        }

        public Task<bool> EmployeeDelete(EmployeeDelete employeeDelete)
        {
            return employeeBL.EmployeeDelete(employeeDelete);
        }

        public Task<List<Employee>> EmployeeUpdate(EmployeeUpdate employeeUpdate)
        {
            return employeeBL.EmployeeUpdate(employeeUpdate);
        }
    }
}
