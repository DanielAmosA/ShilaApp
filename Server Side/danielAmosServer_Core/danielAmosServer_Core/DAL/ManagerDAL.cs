using danielAmosServer_Core.BL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.DB;
using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Helpers.Service;
using danielAmosServer_Core.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using System.Data;

namespace danielAmosServer_Core.DAL
{
    /// <summary>
    /// The ManagerDAL class responsible for Calling the procedures and their data 
    /// According to the managers' area.
    /// </summary>

    public class ManagerDAL : IManagerDAL
    {
        private readonly string connectionString;
        private readonly DataHelper dataHelper;

        public ManagerDAL(DataHelper dataHelper)
        {
            // Reading Connection String from the XML
            connectionString = DbConfigReader.GetConnectionString();
            // Calling and executing helper functions for SQL services.
            this.dataHelper = dataHelper;
        }     
        public async Task<List<Manager>> ManagerSelect()
        {
            SqlParameter[] sqlParameters = new SqlParameter[0];
            DataTable? res = await dataHelper.ExecSPWithRes("Manager_Select", sqlParameters);
            List<Manager> managers;
            if (res != null)
            {
                managers = AppService.ConvertDataTableToList<Manager>(res);
            }
            else
            {
                managers = new List<Manager>();
            }
            return managers;
        }

        public async Task<List<ManagerFallData>> ManagerFullDataSelectByID(int id)
        {
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("@id", id);
            DataTable? res = await dataHelper.ExecSPWithRes("Manager_FullDataSelectByID", sqlParameters);
            List<ManagerFallData> managerFallDatas;
            if (res != null)
            {
                managerFallDatas = AppService.ConvertDataTableToList<ManagerFallData>(res);
            }
            else
            {
                managerFallDatas = new List<ManagerFallData>();
            }
            return managerFallDatas;
        }

        public async Task<List<Employee>> SelectByManager(int id)
        {
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("@ID", id);
            DataTable? res = await dataHelper.ExecSPWithRes("Employee_SelectByManager", sqlParameters);
            List<Employee> employees;
            if (res != null)
            {
                employees = AppService.ConvertDataTableToList<Employee>(res);
            }
            else
            {
                employees = new List<Employee>();
            }
            return employees;
        }
        
        public async Task<List<Manager>> ManagerInsert(Manager manager)
        {
            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(manager);
            DataTable? res = await dataHelper.ExecSPWithRes("Manager_Insert", sqlParameters);
            List<Manager> managers;
            if (res != null)
            {
                managers = AppService.ConvertDataTableToList<Manager>(res);
            }
            else
            {
                managers = new List<Manager>();
            }
            return managers;
        }

        public async Task<List<Log>> LogSelectByType(LogType type)
        {
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("@type", type.ToString());
            DataTable? res = await dataHelper.ExecSPWithRes("Log_SelectByType", sqlParameters);
            List<Log> logs;
            if (res != null)
            {
                logs = AppService.ConvertDataTableToList<Log>(res);
            }
            else
            {
                logs = new List<Log>();
            }
            return logs;
        }

        public async Task<List<History>> HistoryInsert(History history)
        {
            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(history);
            DataTable? res = await dataHelper.ExecSPWithRes("History_Insert", sqlParameters);
            List<History> lHistory;
            if (res != null)
            {
                lHistory = AppService.ConvertDataTableToList<History>(res);
            }
            else
            {
                lHistory = new List<History>();
            }
            return lHistory;
        }

        public async Task<List<HistoryFullData>> HistorySelectByEmployeeID(int employeeID)
        {
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("@employeeID", employeeID);
            DataTable? res = await dataHelper.ExecSPWithRes("History_SelectByEmployeeID", sqlParameters);
            List<HistoryFullData> historyFullDatas;
            if (res != null)
            {
                historyFullDatas = AppService.ConvertDataTableToList<HistoryFullData>(res);
            }
            else
            {
                historyFullDatas = new List<HistoryFullData>();
            }
            return historyFullDatas;
        }

        public async Task<List<Models.Action>> ActionInsert(Models.Action action)
        {
            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(action);
            DataTable? res = await dataHelper.ExecSPWithRes("Action_Insert", sqlParameters);
            List <Models.Action> actions;
            if (res != null)
            {
                actions = AppService.ConvertDataTableToList<Models.Action>(res);
            }
            else
            {
                actions = new List<Models.Action>();
            }
            return actions;
        }

        public async Task<List<Models.Action>> ActionSelect()
        {
            SqlParameter[] sqlParameters = new SqlParameter[0];
            DataTable? res = await dataHelper.ExecSPWithRes("Action_Select", sqlParameters);
            List<Models.Action> actions;
            if (res != null)
            {
                actions = AppService.ConvertDataTableToList<Models.Action>(res);
            }
            else
            {
                actions = new List<Models.Action>();
            }
            return actions;
        }

    }
}
