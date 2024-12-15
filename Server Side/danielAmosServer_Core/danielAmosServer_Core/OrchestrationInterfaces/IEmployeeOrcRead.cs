using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.OrchestrationInterfaces
{
    /// <summary>
    /// The IEmployeeOrcRead interface responsible for Structure declaration for EmployeeOrcRead
    /// </summary>

    public interface IEmployeeOrcRead
    {
        Task<string?> GetThePasswordByEmail(string email);
        Task<List<EmployeeWithManagerData>> SelectByEmailAndPassword(string email, string password);
        Task<List<Employee>> SelectByContaintsFullName(string fullName);
    }
}
