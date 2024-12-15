using danielAmosServer_Core.BLInterfaces;
using danielAmosServer_Core.DAL;
using danielAmosServer_Core.Helpers.Enum;
using danielAmosServer_Core.Helpers.Service;
using danielAmosServer_Core.Models;
using Microsoft.AspNetCore.Http.HttpResults;
using System.Collections;
using System.Collections.Generic;
using System.Data;

namespace danielAmosServer_Core.BL
{
    /// <summary>
    /// The ManagerBL class responsible for Manager Business Logic 
    /// Before being sent to the ManagerDAL (Data Access Layer).
    /// </summary>
     
    public class ManagerBL : IManagerBL
    {

        private readonly ManagerDAL managerDAL;
        private readonly EmployeeDAL employeeDAL;

        public ManagerBL(ManagerDAL managerDAL, EmployeeDAL employeeDAL)
        {
            // Calling and executing services of the DAL (Data Access Layer).
            this.managerDAL = managerDAL;
            this.employeeDAL = employeeDAL;
        }
       
        public async Task<List<Manager>> ManagerSelect()
        {
            return await managerDAL.ManagerSelect();
        }

        public async Task<List<Employee>> SelectByManager(int id)
        {
            return await managerDAL.SelectByManager(id);
        }

        public async Task<List<ManagerFallData>> ManagerFullDataSelectByID(int id)
        {
            return await managerDAL.ManagerFullDataSelectByID(id);
        }

        public async Task<List<ManagerFallData>> ManagerInsert(ManagerFallData managerFallData)
        {
            List<ManagerFallData> managerFallDatas;
            if (managerFallData.Created == default)
                managerFallData.Created = DateTime.Now;
            if (managerFallData.Start == default)
                managerFallData.Start = DateTime.Now;
            managerFallData.Password = AppService.HashPassword(managerFallData.Password!);

            //First, we will add the manager to the employees table,
            //update the relevant data, and only then add to the management table using the generated ID.
            Employee employeeData = new Employee

                {
                FullName = managerFallData.FullName,
                Phone = managerFallData.Phone,
                Email = managerFallData.Email,
                Password = managerFallData.Password,
                Created = managerFallData.Created
                 };
            List<Employee> employee =  await employeeDAL.EmployeeInsert(employeeData);
            if(employee.Count() == 0)
            {
                managerFallDatas = new List<ManagerFallData>();
                return managerFallDatas;
            }

            else
            {
                int? employeeID = employee.ElementAt(0).ID;
                managerFallData.EmployeeID = employeeID;
                managerFallData.FullName = employee.ElementAt(0).FullName;
                managerFallData.Phone = employee.ElementAt(0).Phone;
                managerFallData.Email = employee.ElementAt(0).Email;
                managerFallData.Password = employee.ElementAt(0).Password;
                managerFallData.Created = employee.ElementAt(0).Created;

                Manager managerData = new Manager
                {
                    Role = managerFallData.Role,
                    Department = managerFallData.Department,
                    Start = managerFallData.Start,
                    EmployeeID = managerFallData.EmployeeID
                };

                List<Manager> manager = await managerDAL.ManagerInsert(managerData);
                if (manager.Count() == 0)
                {
                    managerFallDatas = new List<ManagerFallData>();
                    return managerFallDatas;
                }
                managerFallData.ID = manager.ElementAt(0).ID;
                managerFallData.Role = manager.ElementAt(0).Role;
                managerFallData.Department = manager.ElementAt(0).Department;
                managerFallData.Start = manager.ElementAt(0).Start;
                managerFallData.Role = manager.ElementAt(0).Role;
                managerFallDatas = new List<ManagerFallData>();
                managerFallDatas.Add(managerFallData);
                return managerFallDatas;

            }
            
        }

        public Task<List<Log>> LogSelectByType(LogType type)
        {
            return managerDAL.LogSelectByType(type);
        } 

        public Task<List<History>> HistoryInsert(History history)
        {
            if (history.Date == default)
                history.Date = DateTime.Now;
            return managerDAL.HistoryInsert(history);
        }

        public Task<List<HistoryFullData>> HistorySelectByEmployeeID(int employeeID)
        {
            return managerDAL.HistorySelectByEmployeeID(employeeID);
        }
        
        public Task<List<Models.Action>> ActionInsert(Models.Action action)
        {
            return managerDAL.ActionInsert(action);
        }

        public Task<List<Models.Action>> ActionSelect()
        {
            return managerDAL.ActionSelect();
        }


    }
}
