using danielAmosServer_Core.DAL;
using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.BLInterfaces
{
    /// <summary>
    /// The IManagerBL interface responsible for Structure declaration for ManagerBL
    /// </summary>
    public interface IManagerBL
    {
    
        Task<List<Manager>> ManagerSelect();

        Task<List<Employee>> SelectByManager(int id);

        Task<List<ManagerFallData>> ManagerFullDataSelectByID(int id);

        Task<List<ManagerFallData>> ManagerInsert(ManagerFallData managerFallData);

        Task<List<Log>> LogSelectByType(LogType type);

        Task<List<History>> HistoryInsert(History history);

        Task<List<HistoryFullData>> HistorySelectByEmployeeID(int employeeID);

        Task<List<Models.Action>> ActionInsert(Models.Action action);

        Task<List<Models.Action>> ActionSelect();
    }
}
