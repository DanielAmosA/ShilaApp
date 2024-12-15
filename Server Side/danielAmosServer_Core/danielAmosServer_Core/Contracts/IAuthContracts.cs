using danielAmosServer_Core.Helpers.Enum;
using Microsoft.AspNetCore.Mvc;

namespace danielAmosServer_Core.Contracts
{
    /// <summary>
    /// The IAuthContracts interface responsible for Contract management for Auth Controllers
    /// </summary>
    public interface IAuthContracts
    {
        IActionResult GenerateToken(string nameToken, UserRoles role);
    }
}
