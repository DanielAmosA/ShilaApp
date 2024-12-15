using danielAmosServer_Core.BL;
using danielAmosServer_Core.Models;
using danielAmosServer_Core.OrchestrationInterfaces;

namespace danielAmosServer_Core.Orchestration
{
    /// <summary>
    /// The EmployeeOrcRead class responsible for Managing Read requests 
    /// From the EmployeeController (API) to the EmployeeBL (Business Logic).
    /// </summary>

    public class EmployeeOrcRead : IEmployeeOrcRead
    {
        private readonly EmployeeBL employeeBL;

        public EmployeeOrcRead(EmployeeBL employeeBL)
        {
            // Calling and executing services of the BL (Business Logic).
            this.employeeBL = employeeBL;
        }
        public async Task<string?> GetThePasswordByEmail(string email)
        {
            return await employeeBL.GetThePasswordByEmail(email);
        }

        public async Task<List<EmployeeWithManagerData>> SelectByEmailAndPassword(string email, string password)
        {
            return await employeeBL.SelectByEmailAndPassword(email, password);
        }

        public async Task<List<Employee>> SelectByContaintsFullName(string fullName)
        {
            return await employeeBL.SelectByContaintsFullName(fullName);
        }
    }
}
