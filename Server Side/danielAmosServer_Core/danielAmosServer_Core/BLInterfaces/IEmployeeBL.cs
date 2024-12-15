using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.BLInterfaces
{
    /// <summary>
    /// The IEmployeeBL interface responsible for Structure declaration for EmployeeBL
    /// </summary>
    public interface IEmployeeBL
    {
        Task<string?> GetThePasswordByEmail(string email);

        Task<List<EmployeeWithManagerData>> SelectByEmailAndPassword(string email, string password);

        Task<List<Employee>> SelectByContaintsFullName(string fullName);

        Task<List<ManagerWithEmployee>> ManagerWithEmployeeInsert(ManagerWithEmployee managerWithEmployee);

        Task<List<Employee>> EmployeeInsert(Employee employee);

        Task<bool> EmployeeDelete(EmployeeDelete employee);

        Task<List<Employee>> EmployeeUpdate(EmployeeUpdate empoyeeUpdate);
    }
}
