using danielAmosServer_Core.Helpers.CustomException;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace danielAmosServer_Core.Helpers.Middleware
{
    /// <summary>
    /// The class responsible for erros.
    /// </summary>
    /// 
    public class ExceptionRequest
    {
        private readonly RequestDelegate next;

        public ExceptionRequest(RequestDelegate next)
        {
            // Tracking errors.
            this.next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await next(context);
            }
            catch (CreateException ex)
            {
                context.Response.StatusCode = ex.StatusCode;
                context.Response.ContentType = "application/json";
                var errorResponse = new { message = ex.Message };
                await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));
            }

            catch (DeleteException ex)
            {
                context.Response.StatusCode = ex.StatusCode;
                context.Response.ContentType = "application/json";
                var errorResponse = new { message = ex.Message };
                await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));
            }

            catch (FieldsException ex)
            {
                context.Response.StatusCode = ex.StatusCode;
                context.Response.ContentType = "application/json";
                var errorResponse = new { message = ex.Message };
                await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));
            }

            catch (NotFoundException ex)
            {
                context.Response.StatusCode = ex.StatusCode;
                context.Response.ContentType = "application/json";
                var errorResponse = new { message = ex.Message };
                await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));
            }

            catch (SqlException ex)
            {
                context.Response.StatusCode = ex.StatusCode;
                context.Response.ContentType = "application/json";
                var errorResponse = new { message = ex.Message };
                await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));
            }
           
           
            catch (UpdateException ex)
            {
                context.Response.StatusCode = ex.StatusCode;
                context.Response.ContentType = "application/json";
                var errorResponse = new { message = ex.Message };
                await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));
            }
            catch (Exception ex)
            {
                context.Response.StatusCode = 500; // Server error
                context.Response.ContentType = "application/json";
                var errorResponse = new { message = ex.Message };
                await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));
            }
        }
    }
}
