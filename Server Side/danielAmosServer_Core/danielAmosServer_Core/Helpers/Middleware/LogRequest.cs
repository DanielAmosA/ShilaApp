using Serilog;

namespace danielAmosServer_Core.Helpers.Middleware
{
    /// <summary>
    /// The class responsible for logs.
    /// </summary>

    public class LogRequest
    {
        private readonly RequestDelegate next;

        public LogRequest(RequestDelegate next)
        {
            // Go tracking of the HTTP.
            this.next = next;
        }

        public async Task InvokeAsync(HttpContext httpContext)
        {
            var request = httpContext.Request;

            // Info Log
            Log.Information($"Incoming request: {request.Method} {request.Path}");

            try
            {
                await next(httpContext);
            }
            catch (Exception ex)
            {
                //Error Log
                Log.Error(ex, "An error occurred while processing the request");
                throw;
            }
        }
    }
}
