using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Models;
using Microsoft.AspNetCore.Mvc;

namespace danielAmosServer_Core.Contracts
{
    /// <summary>
    /// The IManagerContracts interface responsible for Contract management for ManagerContract Controllers
    /// </summary>
    public interface IManagerContracts 
    {
        Task<IActionResult> ManagerSelect();

        Task<IActionResult> ManagerFullDataSelectByID([FromQuery] int id);

        Task<IActionResult> SelectByManager([FromQuery] int id);
      
        Task<IActionResult> ManagerInsert([FromBody] ManagerFallData managerFallData);

        Task<IActionResult> LogSelectByType([FromQuery] LogType logType);

        Task<IActionResult> HistoryInsert([FromBody] History history);

        Task<IActionResult> HistorySelectByEmployeeID([FromQuery] int employeeID);

        Task<IActionResult> ActionInsert([FromBody] Models.Action action);

        Task<IActionResult> ActionSelect();
    }
}
