namespace danielAmosServer_Core
{
    /// <summary>
    /// The class responsible for JwtSettings.
    /// </summary>
    public class JwtSettings
    {
        public string? SecretKey { get; set; }
        public string? Issuer { get; set; }
        public string? Audience { get; set; }
        public int ExpiryMinutes { get; set; }

    }
}
