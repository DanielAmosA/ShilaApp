using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.OrchestrationInterfaces
{
    /// <summary>
    /// The IEmployeeOrcWrite interface responsible for Structure declaration for EmployeeOrcWrite
    /// </summary>

    public interface IEmployeeOrcWrite
    {
        Task<List<ManagerWithEmployee>> ManagerWithEmployeeInsert(ManagerWithEmployee managerWithEmployee);
        Task<List<Employee>> EmployeeInsert(Employee employee);
        Task<bool> EmployeeDelete(EmployeeDelete employeeDelete);
        Task<List<Employee>> EmployeeUpdate(EmployeeUpdate employeeUpdate);
    }
}
