using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class EmployeeUpdate
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? ID { get; set; }

        [Required]
        [MaxLength(255)]
        public string? FullName { get; set; }

        [Required]
        [MaxLength(20)]
        [Phone]
        public string? Phone { get; set; }

        [Required]
        [MaxLength(255)]
        [EmailAddress]
        public string? Email { get; set; }


    }
}
