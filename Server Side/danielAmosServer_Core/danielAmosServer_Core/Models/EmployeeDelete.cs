using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class EmployeeDelete
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Original_ID { get; set; }

        [Required]
        [MaxLength(255)]
        public required string Original_FullName { get; set; }

        [Required]
        [MaxLength(255)]
        [EmailAddress]
        public required string Original_Email { get; set; }

        [Required]
        [MaxLength(20)]
        [Phone]
        public required string Original_Phone { get; set; }


        public DateTime Original_Created { get; set; }

    }
}
