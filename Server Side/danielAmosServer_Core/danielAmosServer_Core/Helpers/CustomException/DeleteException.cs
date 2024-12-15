namespace danielAmosServer_Core.Helpers.CustomException
{
    /// <summary>
    /// The class responsible for custom error for a situation where the delete failed.
    /// </summary>

    public class DeleteException : Exception
    {
        public int StatusCode { get; set; }

        public DeleteException(string message) : base(message)
        {
            StatusCode = 400;
        }
    }
}
