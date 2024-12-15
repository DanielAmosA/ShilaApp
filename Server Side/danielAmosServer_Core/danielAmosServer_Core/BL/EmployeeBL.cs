using danielAmosServer_Core.BLInterfaces;
using danielAmosServer_Core.DAL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.Service;
using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.BL
{
    /// <summary>
    /// The EmployeeBL class responsible for Employee Business Logic 
    /// Before being sent to the EmployeeDAL (Data Access Layer).
    /// </summary>

    public class EmployeeBL : IEmployeeBL
    {
        private readonly EmployeeDAL employeeDAL;

        public EmployeeBL (EmployeeDAL employeeDAL)
        {
            // Calling and executing services of the DAL (Data Access Layer).
            this.employeeDAL = employeeDAL;
        }

        public async Task<string?> GetThePasswordByEmail(string email)
        {
            return await employeeDAL.GetThePasswordByEmail(email);
        }

        public async Task<List<EmployeeWithManagerData>> SelectByEmailAndPassword(string email, string password)
        {
            // We will first validate the email and password, and only then retrieve the data.
            List<EmployeeWithManagerData> employeeWithManagerData;
            string? passwordHash = await employeeDAL.GetThePasswordByEmail(email);
            if (passwordHash == null)
            {
                employeeWithManagerData = new List<EmployeeWithManagerData>();
                return employeeWithManagerData;
            }
            else
            {
                if (AppService.VerifyPassword(password, (string)passwordHash))
                {
                    return await employeeDAL.SelectByEmail(email);
                }
                else
                {
                    employeeWithManagerData = new List<EmployeeWithManagerData>();
                    return employeeWithManagerData;
                }
            }

        }

        public async Task<List<Employee>> SelectByContaintsFullName(string fullName)
        {
            return await employeeDAL.SelectByContaintsFullName(fullName);
        }

        public async Task<List<ManagerWithEmployee>> ManagerWithEmployeeInsert(ManagerWithEmployee managerWithEmployee)
        {
            return await employeeDAL.ManagerWithEmployeeInsert(managerWithEmployee);
        }

        public async Task<List<Employee>> EmployeeInsert(Employee employee)
        {
            if (employee.Created == default)
                employee.Created = DateTime.Now;
            employee.Password = AppService.HashPassword(employee.Password!);
            return await employeeDAL.EmployeeInsert(employee);
        }

        public Task<bool> EmployeeDelete(EmployeeDelete employeeDelete)
        {
            return employeeDAL.EmployeeDelete(employeeDelete);
        }

        public Task<List<Employee>> EmployeeUpdate(EmployeeUpdate empoyeeUpdate)
        {
            return employeeDAL.EmployeeUpdate(empoyeeUpdate);
        }

    }
}
