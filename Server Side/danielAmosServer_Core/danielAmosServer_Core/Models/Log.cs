using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class Log
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? ID { get; set; }

        [Required]
        [MaxLength(50)]
        public string? Type { get; set; }

        [Required]
        public string? Info { get; set; }

        public DateTime Created { get; set; }

        public string? RequestData { get; set; }

        public string? ExceptionData { get; set; }
    }
}
