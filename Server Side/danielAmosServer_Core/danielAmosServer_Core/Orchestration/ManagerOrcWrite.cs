using danielAmosServer_Core.BL;
using danielAmosServer_Core.Models;
using danielAmosServer_Core.OrchestrationInterfaces;

namespace danielAmosServer_Core.Orchestration
{
    /// <summary>
    /// The ManagerOrcWrite class responsible for Managing Write requests 
    /// From the ManagerController (API) to the ManagerBL (Business Logic).
    /// </summary>

    public class ManagerOrcWrite : IManagerOrcWrite
    {
        private readonly ManagerBL managerBL;

        public ManagerOrcWrite(ManagerBL managerBL)
        {
            // Calling and executing services of the BL (Business Logic).
            this.managerBL = managerBL;
        }

        public async Task<List<ManagerFallData>> ManagerInsert(ManagerFallData managerFallData)
        {
            return await managerBL.ManagerInsert(managerFallData);
        }
        
        public async Task<List<History>> HistoryInsert(History history)
        {
            return await managerBL.HistoryInsert(history);
        }

        public async Task<List<Models.Action>> ActionInsert(Models.Action action)
        {
            return await managerBL.ActionInsert(action);
        }
    }
}
