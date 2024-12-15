using danielAmosServer_Core.Models;
using Microsoft.AspNetCore.Mvc;
using System.Runtime.Serialization;

namespace danielAmosServer_Core.Contracts
{
    /// <summary>
    /// The IEmployeContracts interface responsible for Contract management for Employe Controllers
    /// </summary>
    public interface IEmployeeContracts
    {
        Task<IActionResult> GetThePasswordByEmail([FromQuery] string email);

        Task<IActionResult> SelectByEmailAndPassword([FromQuery] string email, [FromQuery] string password);

        Task<IActionResult> SelectByContaintsFullName([FromQuery] string fullName);

        Task<IActionResult> ManagerWithEmployeeInsert([FromBody] ManagerWithEmployee managerWithEmployee);

        Task<IActionResult> EmployeeInsert([FromBody] Employee employee);
        
        Task<IActionResult> EmployeeDelete([FromBody] EmployeeDelete employeeDelete);
        
        Task<IActionResult> EmployeeUpdate([FromBody] EmployeeUpdate employeeUpdate);

    }
}
