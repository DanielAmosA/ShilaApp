using danielAmosServer_Core.BL;
using danielAmosServer_Core.DAL;
using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.OrchestrationInterfaces
{
    /// <summary>
    /// The IManagerOrcRead interface responsible for Structure declaration for ManagerOrcRead
    /// </summary>

    public interface IManagerOrcRead
    {
        Task<List<Manager>> ManagerSelect();
        Task<List<ManagerFallData>> ManagerFullDataSelectByID(int id);
        Task<List<Employee>> SelectByManager(int id);
        Task<List<Log>> LogSelectByType(LogType type);
        Task<List<HistoryFullData>> HistorySelectByEmployeeID(int employeeID);
        Task<List<Models.Action>> ActionSelect();
    }
}
