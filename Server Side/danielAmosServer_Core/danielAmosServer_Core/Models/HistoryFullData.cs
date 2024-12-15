using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class HistoryFullData
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? ID { get; set; }

        [Required]
        public DateTime Date { get; set; }

        [ForeignKey("ActionID")]
        public int? ActionID { get; set; }

        [ForeignKey("EmployeeID")]
        public int? EmployeeID { get; set; }

        [ForeignKey("ManagerID")]
        public int? ManagerID { get; set; }

        [MaxLength(255)]
        public string? Type { get; set; }

        [Required]
        [MaxLength(255)]
        public string? Description { get; set; }

        [Required]
        [MaxLength(255)]
        public string? ManagerFullName { get; set; }



    }
}
