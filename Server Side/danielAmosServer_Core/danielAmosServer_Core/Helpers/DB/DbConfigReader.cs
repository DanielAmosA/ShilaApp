namespace danielAmosServer_Core.Helpers.DB
{
    using Serilog;
    using System.Xml;

    /// <summary>
    /// The class responsible for Sql config.
    /// </summary>
    /// 
    public static class DbConfigReader
    {
        public static string GetConnectionString()
        {
            string filePath = "DbConfig.xml";
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(filePath);
            Log.Information("DbConfig.xml Loading");

            XmlNode? connectionStringNode = xmlDoc.SelectSingleNode("//ConnectionString");
            if (connectionStringNode == null)
            {
                Log.Fatal("Connection string not found in DbConfig.xml");
                throw new Exception("Connection string not found in DbConfig.xml");
            }
            Log.Information($"Connection string = {connectionStringNode.InnerText}");
            return connectionStringNode.InnerText;
        }
    }


}
