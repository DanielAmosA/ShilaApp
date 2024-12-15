using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace danielAmosServer_Core.Models
{
    public class Action
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? ID { get; set; }

        [Required]
        [MaxLength(255)]
        public string? Description { get; set; }

        [MaxLength(255)]
        public string? Type { get; set; }
    }
}
