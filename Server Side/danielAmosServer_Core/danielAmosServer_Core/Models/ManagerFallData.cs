using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http.HttpResults;

namespace danielAmosServer_Core.Models
{
    public class ManagerFallData
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? ID { get; set; }

        [Required]
        [MaxLength(255)]
        public string? Role { get; set; }

        [Required]
        [MaxLength(255)]
        public string? Department { get; set; }

        public DateTime Start { get; set; }

        [ForeignKey("EmployeeID")]
        public int? EmployeeID { get; set; }

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

        [MaxLength(255)]
        public string? ManagerFullName { get; set; }
    }
}