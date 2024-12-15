namespace danielAmosServer_Core.Helpers.Middleware
{

    /// <summary>
    /// The IAppService interface responsible for Structure declaration for RequestLoggingMiddleware
    /// </summary>

    public interface ILogRequest
    {
        Task InvokeAsync(HttpContext httpContext);
    }
}
