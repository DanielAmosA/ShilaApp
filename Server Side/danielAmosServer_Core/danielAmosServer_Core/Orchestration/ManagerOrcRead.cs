using danielAmosServer_Core.BL;
using danielAmosServer_Core.DAL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Models;
using danielAmosServer_Core.OrchestrationInterfaces;

namespace danielAmosServer_Core.Orchestration
{
    /// <summary>
    /// The ManagerOrcRead class responsible for Managing Read requests 
    /// From the ManagerController (API) to the ManagerBL (Business Logic).
    /// </summary>

    public class ManagerOrcRead : IManagerOrcRead
    {
        private readonly ManagerBL managerBL;

        public ManagerOrcRead(ManagerBL managerBL)
        {
            // Calling and executing services of the BL (Business Logic).
            this.managerBL = managerBL;
        }

        public async Task<List<Manager>> ManagerSelect()
        {
            return await managerBL.ManagerSelect();
        }

        public async Task<List<ManagerFallData>> ManagerFullDataSelectByID(int id)
        {
            return await managerBL.ManagerFullDataSelectByID(id);
        }
        

        public async Task<List<Employee>> SelectByManager(int id)
        {
            return await managerBL.SelectByManager(id);
        }

        public async Task<List<Log>> LogSelectByType(LogType type)
        {
            return await managerBL.LogSelectByType(type);
        }
        
        public async Task<List<HistoryFullData>> HistorySelectByEmployeeID(int employeeID)
        {
            return await managerBL.HistorySelectByEmployeeID(employeeID);
        }

        public async Task<List<Models.Action>> ActionInsert(Models.Action action)
        {
            return await managerBL.ActionInsert(action);
        }
        
        public async Task<List<Models.Action>> ActionSelect()
        {
            return await managerBL.ActionSelect();
        }

    }
}
