using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class EmployeeMainData
    {
       
        [Required]
        [MaxLength(255)]
        public string? FullName { get; set; }

        [Required]
        [MaxLength(255)]
        [EmailAddress]
        public string? Email { get; set; }

        [Required]
        [MaxLength(20)]
        [Phone]
        public string? Phone { get; set; }

        [Required]
        [MaxLength(255)]
        public string? Password { get; set; }

        public DateTime Created { get; set; }

        public Guid? GUID { get; set; }
    }
}
