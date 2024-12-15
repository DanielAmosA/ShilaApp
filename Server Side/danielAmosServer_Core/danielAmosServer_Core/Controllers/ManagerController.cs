using danielAmosServer_Core.BL;
using danielAmosServer_Core.Contracts;
using danielAmosServer_Core.Helpers.CustomException;
using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Helpers.Service;
using danielAmosServer_Core.Models;
using danielAmosServer_Core.Orchestration;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Serilog;

namespace danielAmosServer_Core.Controllers
{
    /// <summary>
    /// The ManagerController Controller responsible for API actions for a Authorized user (Manager)
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    public class ManagerController : ControllerBase , IManagerContracts
    {
        private readonly ManagerOrcRead managerOrcRead;
        private readonly ManagerOrcWrite managerOrcWrite;

        public ManagerController(ManagerOrcRead managerOrcRead, ManagerOrcWrite managerOrcWrite)
        {
            // Calling and executing services of the Orc (Orchestration).
            this.managerOrcRead = managerOrcRead;
            this.managerOrcWrite = managerOrcWrite;
        }


        /// <summary>
        /// A service for select managers.
        /// </summary>
        /// <returns> A list of all managers.</returns>

        [Authorize(Roles = "Manager")]
        [HttpGet("ManagerSelect")]
        public async Task<IActionResult> ManagerSelect()
        {
            List<Manager> managers = await managerOrcRead.ManagerSelect();
              
            if (managers.Count() == 0)
            {
                throw new NotFoundException("That's it, the company has moved to the cloud – there are no more managers, only robots X O X O.");
            }
            return Ok(managers);
        }


        /// <summary>
        /// A service for select managers and employee data.
        /// </summary>
        /// <param name="id">emplyee id for the search.</param>
        /// <returns> A manager data.</returns>
        /// <returns> A list of all managers.</returns>

        [Authorize(Roles = "Manager, Employee")]
        [HttpGet("ManagerFullDataSelectByID")]
        public async Task<IActionResult> ManagerFullDataSelectByID([FromQuery] int id)
        {
            List<ManagerFallData> managerFallDatas = await managerOrcRead.ManagerFullDataSelectByID(id);
            if (managerFallDatas.Count() == 0)
            {
                throw new NotFoundException($"No employees were found for the employee ID is - {id}");
            }
            return Ok(managerFallDatas);
        }

        /// <summary>
        /// A service for select employees by manager id.
        /// </summary>
        /// <param name="id">manager id for the search.</param>
        /// <returns> A list of all employees assigned to a manager.</returns>

        [Authorize(Roles = "Manager")]
        [HttpGet("SelectByManager")]
        public async Task<IActionResult> SelectByManager([FromQuery] int id)
        {
            List<Employee> employees = await managerOrcRead.SelectByManager(id);
            if (employees.Count() == 0)
            {
                throw new NotFoundException($"No employees were found for the manager whose ID is - {id}");
            }
            return Ok(employees);
        }

        /// <summary>
        /// A service for add manager.
        /// </summary>
        /// <param name="manager">manager data for the insert.</param>
        /// <returns> A manager data that insert.</returns> 

        [HttpPost("ManagerInsert")]
        public async Task<IActionResult> ManagerInsert([FromBody] ManagerFallData managerFallData)
        {
            if (!ModelState.IsValid)
            {
                throw new CreateException("The add operation failed, one of the fields is incorrect.");
            }

            List<ManagerFallData> managers = await managerOrcWrite.ManagerInsert(managerFallData);
            if (managers.Count() == 0)
            {
                throw new CreateException("The addition failed try another email maybe...");
            }
            return Ok(managers);

        }

        /// <summary>
        /// A service for get logs.
        /// </summary>
        /// <param name="type">log type for the select.</param>
        /// <returns> A logs that with the type of type.</returns> 

        [HttpGet("LogSelectByType")]
        public async Task<IActionResult> LogSelectByType([FromQuery] LogType logType)
        {
            if (!ModelState.IsValid)
            {
                throw new CreateException("The select operation failed, one of the fields is incorrect.");
            }

            List<Models.Log> logs = await managerOrcRead.LogSelectByType(logType);
            if (logs.Count() == 0)
            {
                throw new NotFoundException($"Logs with type - {logType} not found");
            }
            return Ok(logs);

        }


        /// <summary>
        /// A service for add history.
        /// </summary>
        /// <param name="manager">history data for the insert.</param>
        /// <returns> A history data that insert.</returns> 

        [Authorize(Roles = "Manager")]
        [HttpPost("HistoryInsert")]
        public async Task<IActionResult> HistoryInsert([FromBody] History history)
        {
            if (!ModelState.IsValid)
            {
                throw new CreateException("The add operation failed, one of the fields is incorrect.");
            }

            List<History> lHistory = await managerOrcWrite.HistoryInsert(history);
            if (lHistory.Count() == 0)
            {
                throw new CreateException("The addition failed try again soon...");
            }
            return Ok(lHistory);

        }

        /// <summary>
        /// A service for get history.
        /// </summary>
        /// <param name="employeeID">employee id for the select.</param>
        /// <returns> A History that with the employee id of employeeID.</returns> 

        [Authorize(Roles = "Manager, Employee")]
        [HttpGet("HistorySelectByEmployeeID")]
        public async Task<IActionResult> HistorySelectByEmployeeID([FromQuery] int employeeID)
        {
            List<HistoryFullData> historyFullDatas = await managerOrcRead.HistorySelectByEmployeeID(employeeID);
            if (historyFullDatas.Count() == 0)
            {
                throw new NotFoundException($"History with employee id - {employeeID} not found");
            }
            return Ok(historyFullDatas);

        }

        /// <summary>
        /// A service for add action.
        /// </summary>
        /// <param name="manager">history data for the insert.</param>
        /// <returns> A history data that insert.</returns> 

        [Authorize(Roles = "Manager")]
        [HttpPost("ActionInsert")]
        public async Task<IActionResult> ActionInsert([FromBody] Models.Action action)
        {
           
            if (!ModelState.IsValid)
            {
                throw new CreateException("The add operation failed, one of the fields is incorrect.");
            }

            List<Models.Action> actions = await managerOrcWrite.ActionInsert(action);
            if (actions.Count() == 0)
            {
                throw new CreateException("The addition failed try again soon...");
            }
            return Ok(actions);

        }

        /// <summary>
        /// A service for get actions.
        /// </summary>
        /// <returns> all actions</returns> 

        [Authorize(Roles = "Manager")]
        [HttpGet("ActionSelect")]
        public async Task<IActionResult> ActionSelect()
        {

            List<Models.Action> actions = await managerOrcRead.ActionSelect();
            if (actions.Count() == 0)
            {
                throw new NotFoundException("It's time to go out and discover – there are no more actions.");
            }
            return Ok(actions);

        }
    }
}
