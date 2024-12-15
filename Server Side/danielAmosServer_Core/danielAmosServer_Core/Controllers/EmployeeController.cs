using danielAmosServer_Core.Contracts;
using danielAmosServer_Core.Helpers.CustomException;
using danielAmosServer_Core.Models;
using danielAmosServer_Core.Orchestration;
using danielAmosServer_Core.OrchestrationInterfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace danielAmosServer_Core.Controllers
{
    /// <summary>
    /// The Employee Controller responsible for API actions for a Regular user (Employee)
    /// </summary>
    [Route("api/Employee")]
    [ApiController]
    public class EmployeeController : ControllerBase, IEmployeeContracts
    {
        private readonly EmployeeOrcRead employeeOrcRead;
        private readonly EmployeeOrcWrite employeeOrcWrite;

        public EmployeeController(EmployeeOrcRead employeeOrcRead, EmployeeOrcWrite employeeOrcWrite)
        {
            // Calling and executing services of the Orc (Orchestration).
            this.employeeOrcRead = employeeOrcRead;
            this.employeeOrcWrite = employeeOrcWrite;
        }

        /// <summary>
        /// A service for select employees by full name and password.
        /// </summary>
        /// <param name="email">email for the search.</param>
        /// <param name="password">password for the search.</param>
        /// <returns> A list of all employees containing the received email and password.</returns>

        [Authorize(Roles = "Manager, Employee")]
        [HttpGet("GetThePasswordByEmail")]
        public async Task<IActionResult> GetThePasswordByEmail([FromQuery] string email)
        {
            string? password = await employeeOrcRead.GetThePasswordByEmail(email);
            if (password == null)
            {
                throw new NotFoundException($"Employee with Email {email} not found");
            }
            return Ok(password);
        }

        /// <summary>
        /// A service for select employees by full name and password.
        /// </summary>
        /// <param name="email">email for the search.</param>
        /// <param name="password">password for the search.</param>
        /// <returns> A list of all employees containing the received email and password.</returns>

        [HttpGet("SelectByEmailAndPassword")]
        public async Task<IActionResult> SelectByEmailAndPassword([FromQuery] string email, [FromQuery] string password)
        {
            List<EmployeeWithManagerData> employees = await employeeOrcRead.SelectByEmailAndPassword(email, password);
            if (employees.Count() == 0)
            {
                throw new NotFoundException($"Employee with Email = > {email}  and password = > {password} not found");
            }
            return Ok(employees);
        }

        /// <summary>
        /// A service for select employees by containts full name.
        /// </summary>
        /// <param name="fullName">Name for the search.</param>
        /// <returns> A list of all employees containing the received name.</returns>

        [Authorize(Roles = "Manager")]
        [HttpGet("SelectByContaintsFullName")]
        public async Task<IActionResult> SelectByContaintsFullName([FromQuery] string fullName)
        {
            List<Employee> employees = await employeeOrcRead.SelectByContaintsFullName(fullName);
            if (employees.Count() == 0)
            {
                throw new NotFoundException($"Employee with FullName {fullName} not found");
            }
            return Ok(employees);
        }

        /// <summary>
        /// A service for add manager with employee.
        /// </summary>
        /// <param name="managerWithEmployees">manager With employees data for the insert.</param>
        /// <returns> A manager With employees data that insert.</returns> 
        [Authorize(Roles = "Manager")]
        [HttpPost("ManagerWithEmployeeInsert")]
        public async Task<IActionResult> ManagerWithEmployeeInsert([FromBody] ManagerWithEmployee managerWithEmployee)
        {
            if (!ModelState.IsValid)
            {
                throw new CreateException("The add operation failed, one of the fields is incorrect.");
            }

            List<ManagerWithEmployee> managerWithEmployees = await employeeOrcWrite.ManagerWithEmployeeInsert(managerWithEmployee);
            if (managerWithEmployees.Count() == 0)
            {
                throw new CreateException("The addition failed try again soon...");
            }
            return Ok(managerWithEmployees);

        }

        /// <summary>
        /// A service for add employee.
        /// </summary>
        /// <param name="employee">employee data for the insert.</param>
        /// <returns> A employee data that insert.</returns> 
        [Authorize(Roles = "Manager")]
        [HttpPost("EmployeeInsert")]
        public async Task<IActionResult> EmployeeInsert([FromBody] Employee employee)
        {
            if (!ModelState.IsValid)
            {
                throw new CreateException("The add operation failed, one of the fields is incorrect.");
            }

            List<Employee> employees = await employeeOrcWrite.EmployeeInsert(employee);
            if (employees.Count() == 0)
            {
                throw new CreateException("The addition failed try again soon maybe another email ? ...");
            }
            return Ok(employees);

        }

        /// <summary>
        /// A service for add employee.
        /// </summary>
        /// <param name="employeeDelete">employee data for the delete.</param>
        /// <returns> A string indicating whether the deletion succeeded.</returns> 
        [Authorize(Roles = "Manager")]
        [HttpPost("EmployeeDelete")]
        public async Task<IActionResult> EmployeeDelete([FromBody] EmployeeDelete employeeDelete)
        {
            if (!ModelState.IsValid)
            {
                throw new DeleteException("The delete operation failed, one of the fields is incorrect.");
            }

            if (!await employeeOrcWrite.EmployeeDelete(employeeDelete))
            {
                throw new NotFoundException("No rows were deleted.");
            }

            return Ok(new { message = "Row deleted successfully." });

        }

        /// <summary>
        /// A service for update employee.
        /// </summary>
        /// <param name="employeeUpdate">employee data for the update.</param>
        /// <returns> A employee data that update.</returns> 
        [Authorize(Roles = "Manager, Employee")]
        [HttpPost("EmployeeUpdate")]
        public async Task<IActionResult> EmployeeUpdate([FromBody] EmployeeUpdate employeeUpdate)
        {
            if (!ModelState.IsValid)
            {
                throw new UpdateException("The update operation failed, one of the fields is incorrect.");
            }

            List<Employee> employees = await employeeOrcWrite.EmployeeUpdate(employeeUpdate);
            if (employees.Count() == 0)
            {
                throw new UpdateException("The update failed try again soon...");
            }
            return Ok(employees);

        }
    }
}
