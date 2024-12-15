using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class EmployeeWithManagerData
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? ID { get; set; }

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

        public DateTime Created { get; set; }

        [Required]
        public bool IsManager { get; set; }

        [MaxLength(255)]
        public string? Role { get; set; }

        [MaxLength(255)]
        public string? Department { get; set; }

        public DateTime Start { get; set; }
    }
}
