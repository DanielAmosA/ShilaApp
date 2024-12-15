namespace danielAmosServer_Core.Helpers.CustomException
{
    /// <summary>
    /// The class responsible for custom error for a situation where the sql failed.
    /// </summary>

    public class SqlException : Exception
    {
        public int StatusCode { get; set; }

        public SqlException(string message) : base(message)
        {
            StatusCode = 401;
        }
    }
}
