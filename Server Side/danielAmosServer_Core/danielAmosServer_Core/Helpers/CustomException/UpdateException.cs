﻿namespace danielAmosServer_Core.Helpers.CustomException
{
    /// <summary>
    /// The class responsible for custom error for a situation for a situation where the update failed.
    /// </summary>

    public class UpdateException : Exception
    {
        public int StatusCode { get; set; }

        public UpdateException(string message) : base(message)
        {
            StatusCode = 400;
        }
    }
}
