using danielAmosServer_Core.BL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.DB;
using danielAmosServer_Core.Helpers.Service;
using danielAmosServer_Core.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace danielAmosServer_Core.DAL
{

    /// <summary>
    /// The EmployeeDAL class responsible for Calling the procedures and their data 
    /// According to the employees' area.
    /// </summary>

    public class EmployeeDAL : IEmployeeDAL
    {
        private readonly string connectionString;
        private readonly DataHelper dataHelper;

        public EmployeeDAL(DataHelper dataHelper)
        {
            //Reading Connection String from the XML
            connectionString = DbConfigReader.GetConnectionString();
            // Calling and executing helper functions for SQL services.
            this.dataHelper = dataHelper;
        }
        public async Task<string?> GetThePasswordByEmail(string email)
        {
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("@email", email);
            Object? res = await dataHelper.ExecSPAsScalar("Employee_GetThePasswordByEmail", sqlParameters);
            if (res != null)
            {
                return res as string;
            }
            else
            {
                return null;
            }
        }

        public async Task<List<EmployeeWithManagerData>> SelectByEmail(string email)
        {
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("@email", email);
            DataTable? res = await dataHelper.ExecSPWithRes("Employee_SelectByEmail", sqlParameters);
            List<EmployeeWithManagerData> employeeWithManagerData;
            if (res != null)
            {
                employeeWithManagerData = AppService.ConvertDataTableToList<EmployeeWithManagerData>(res);
            }
            else
            {
                employeeWithManagerData = new List<EmployeeWithManagerData>();
            }
            return employeeWithManagerData;

        }

        public async Task<List<Employee>> SelectByContaintsFullName(string fullName)
        {
            SqlParameter[] sqlParameters = new SqlParameter[1];
            sqlParameters[0] = new SqlParameter("@fullName", fullName);
            DataTable? res = await dataHelper.ExecSPWithRes("Employee_SelectByContaintsFullName", sqlParameters);
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


        public async Task<List<Employee>> EmployeeInsert(Employee employee)
        {
            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(employee);
            DataTable? res = await dataHelper.ExecSPWithRes("Employee_Insert", sqlParameters);
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
        public async Task<List<ManagerWithEmployee>> ManagerWithEmployeeInsert(ManagerWithEmployee managerWithEmployee)
        {

            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(managerWithEmployee);
            DataTable? res = await dataHelper.ExecSPWithRes("ManagerWithEmployee_Insert", sqlParameters);
            List<ManagerWithEmployee> employees;
            if (res != null)
            {
                employees = AppService.ConvertDataTableToList<ManagerWithEmployee>(res);
            }
            else
            {
                employees = new List<ManagerWithEmployee>();
            }
            return employees;
        }

        public async Task<bool> EmployeeDelete(EmployeeDelete employeeDelete)
        {
            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(employeeDelete);
            return await dataHelper.ExecSPWithoutRes("Employee_Delete", sqlParameters);
        }

        public async Task<List<Employee>> EmployeeUpdate(EmployeeUpdate empoyeeUpdate)
        {
            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(empoyeeUpdate);
            DataTable? res = await dataHelper.ExecSPWithRes("Employee_Update", sqlParameters);
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

    }
}
