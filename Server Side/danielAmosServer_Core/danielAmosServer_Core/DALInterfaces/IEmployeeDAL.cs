using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.DALInterfaces
{
    /// <summary>
    /// The IEmployeeDAL interface responsible for Structure declaration for EmployeeDAL
    /// </summary>
    
    public interface IEmployeeDAL
    {
        Task<string?> GetThePasswordByEmail(string email);
        Task<List<EmployeeWithManagerData>> SelectByEmail(string email);
        Task<List<Employee>> SelectByContaintsFullName(string fullName);
        Task<List<ManagerWithEmployee>> ManagerWithEmployeeInsert(ManagerWithEmployee managerWithEmployee);
        Task<List<Employee>> EmployeeInsert(Employee employee);
        Task<bool> EmployeeDelete(EmployeeDelete employee);
        Task<List<Employee>> EmployeeUpdate(EmployeeUpdate empoyeeUpdate);
    }
}
