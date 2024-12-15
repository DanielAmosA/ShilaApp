using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class History
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? ID { get; set; }

        public DateTime Date { get; set; }

        [ForeignKey("ActionID")]
        public int? ActionID { get; set; }

        [ForeignKey("EmployeeID")]
        public int? EmployeeID { get; set; }

        [ForeignKey("ManagerID")]
        public int? ManagerID { get; set; }

        public int? ManagerEmployeeID { get; set; }
    }
}
