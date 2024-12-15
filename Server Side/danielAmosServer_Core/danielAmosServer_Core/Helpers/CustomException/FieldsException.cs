namespace danielAmosServer_Core.Helpers.CustomException
{
    /// <summary>
    /// The class responsible for custom error for a situation where the Fields error.
    /// </summary>

    public class FieldsException : Exception
    {
        public int StatusCode { get; set; }

        public FieldsException(string message) : base(message)
        {
            StatusCode = 400;
        }
    }
}
