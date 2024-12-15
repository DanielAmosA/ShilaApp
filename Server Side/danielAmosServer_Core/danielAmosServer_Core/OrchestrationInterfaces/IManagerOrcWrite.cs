using danielAmosServer_Core.DAL;
using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.OrchestrationInterfaces
{
    /// <summary>
    /// The IManagerOrcWrite interface responsible for Structure declaration for ManagerOrcWrite
    /// </summary>

    public interface IManagerOrcWrite
    {    
        Task<List<ManagerFallData>> ManagerInsert(ManagerFallData managerFallData);
        Task<List<History>> HistoryInsert(History history);
        Task<List<Models.Action>> ActionInsert(Models.Action action);
    }
}
