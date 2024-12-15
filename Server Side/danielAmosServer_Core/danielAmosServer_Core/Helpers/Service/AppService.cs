using danielAmosServer_Core.Helpers.CustomException;
using danielAmosServer_Core.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Serilog;
using System.Data;
using System.Reflection;

namespace danielAmosServer_Core.Helpers.Service
{
    /// <summary>
    /// The class responsible for helper action.
    /// </summary>
    
    public class AppService
    {
        #region Hash
        //  dummy user => no storing data
        public class UserHasher { }

        // We will convert the received password to a hash.
        public static string HashPassword(string password)
        {
            if (string.IsNullOrEmpty(password))
                throw new FieldsException("Password cannot be null or empty");
            PasswordHasher<UserHasher> passwordHasher = new PasswordHasher<UserHasher>();
            var userHasher = new UserHasher();
            string hashedPassword = passwordHasher.HashPassword(userHasher, password);
            return hashedPassword;
        }

        // After conversion,
        // we will check if the entered password matches the password stored in the hash.
        public static bool VerifyPassword(string currentPassword, string storedHash)
        {
            if (string.IsNullOrEmpty(currentPassword))
                throw new FieldsException("Password cannot be null or empty");
            if (string.IsNullOrEmpty(storedHash))
                throw new FieldsException("Password cannot be null or empty");

            PasswordHasher<UserHasher> passwordHasher = new PasswordHasher<UserHasher>();
            var UserHasher = new UserHasher();
            var result = passwordHasher.VerifyHashedPassword(UserHasher, storedHash, currentPassword);

            return result == PasswordVerificationResult.Success;
        }

        #endregion

        #region Generic

        // We will create a generic function
        // that converts a DataTable
        // into a list of objects of the desired model.
        public static List<T> ConvertDataTableToList<T>(DataTable dataTable) where T : new()
        {
            var list = new List<T>();

            foreach (DataRow row in dataTable.Rows)
            {
                T obj = new T();

                foreach (DataColumn column in dataTable.Columns)
                {
                    var property = typeof(T).GetProperty(column.ColumnName, BindingFlags.Public | BindingFlags.Instance | BindingFlags.IgnoreCase);
                    if (property != null)
                    {
                        var value = row[column];
                        if (value == DBNull.Value)
                        {
                            property.SetValue(obj, null);
                        }
                        else
                        {
                            property.SetValue(obj, Convert.ChangeType(value, Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType));
                        }
                    }
                }

                list.Add(obj);
            }

            return list;
        }



        // We will create a generic function
        // that converts a Model
        // into a array of params of the desired model.
        public static SqlParameter[] GenerateSqlParameters<T>(T model)
        {
            PropertyInfo[] properties = typeof(T).GetProperties();
            var parameters = new List<SqlParameter>();
            foreach (var property in properties)
            {
                var value = property.GetValue(model);

                if (value != null)
                {
                    string paramName = $"@{property.Name}";
                    parameters.Add(new SqlParameter(paramName, value));
                }
            }
            return parameters.ToArray();
        }

        // General customized log messages.
        public static void CreateLogInfo(string section, string desc)
        {
            Serilog.Log.Information($"{section} - {desc}");
        }

        public static void CreateErrorInfo(string section, string desc)
        {
            Serilog.Log.Error($"{section} - {desc}");
        }

        #endregion

    }
}
