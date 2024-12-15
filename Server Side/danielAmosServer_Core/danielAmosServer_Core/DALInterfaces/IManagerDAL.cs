using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.DALInterfaces
{
    /// <summary>
    /// The IEmployeeDAL interface responsible for Structure declaration for EmployeeDAL
    /// </summary>
     
    public interface IManagerDAL
    {      
        Task<List<Employee>> SelectByManager(int id);

        Task<List<Manager>> ManagerSelect();

        Task<List<ManagerFallData>> ManagerFullDataSelectByID(int id);

        Task<List<Manager>> ManagerInsert(Manager manager);

        Task<List<Log>> LogSelectByType(LogType type);

        Task<List<History>> HistoryInsert(History history);

        Task<List<HistoryFullData>> HistorySelectByEmployeeID(int employeeID);

        Task<List<Models.Action>> ActionInsert(Models.Action action);

        Task<List<Models.Action>> ActionSelect();
    }
}
