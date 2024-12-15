namespace danielAmosServer_Core.Helpers.Middleware
{
    /// <summary>
    /// The IAppService interface responsible for Structure declaration for IExecption
    /// </summary>
    public interface IExecption
    {
        Task InvokeAsync(HttpContext context);
    }
}
