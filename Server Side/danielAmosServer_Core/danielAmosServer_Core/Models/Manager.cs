using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class Manager
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

        public string? EmployeeName { get; set; }
    }
}
