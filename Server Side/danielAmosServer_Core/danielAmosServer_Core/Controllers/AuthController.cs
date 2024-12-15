using danielAmosServer_Core.Contracts;
using danielAmosServer_Core.Helpers.Enum;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace danielAmosServer_Core.Controllers
{

    /// <summary>
    /// The Auth Controller responsible for API actions for Authentication action.
    /// </summary>

    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase , IAuthContracts
    {
        private readonly JwtSettings _jwtSettings;

        public AuthController(JwtSettings jwtSettings)
        {
            _jwtSettings = jwtSettings;
        }

        /// <summary>
        /// A service for generating a token.
        /// </summary>
        /// <param name="nameToken">Name for the token.</param>
        /// <param name="role">Role for the token.</param>
        /// <returns>Generates a new token with jwtSettings values 
        ///          and an expiration of ExpiryMinutes.</returns>
        [HttpPost("GenerateToken")]
        public IActionResult GenerateToken(string nameToken, UserRoles role)
        {
            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, nameToken),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(ClaimTypes.Role, role.ToString())
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtSettings.SecretKey!));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: _jwtSettings.Issuer,
                audience: _jwtSettings.Audience,
                claims: claims,
                expires: DateTime.Now.AddMinutes(_jwtSettings.ExpiryMinutes),
                signingCredentials: creds
            );
            return Ok(new
            {
                success = true,
                token = new JwtSecurityTokenHandler().WriteToken(token),
                expiresAt = token.ValidTo
            });
        }
    }
}
