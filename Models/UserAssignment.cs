using JustLearn1.Models;
using System.ComponentModel.DataAnnotations;

public class UserAssignment
{
    public int Id { get; set; }
    public string UserId { get; set; }
    public int AssignmentId { get; set; }
    public bool IsSubmitted { get; set; }
    public DateTime? SubmissionDate { get; set; }
    
    [Range(0, 100, ErrorMessage = "Score must be between 0 and 100")]
    public int? Score { get; set; }
    
    [Display(Name = "Answer")]
    public string? UserAnswer { get; set; }
    
    [Display(Name = "Feedback")]
    public string? Feedback { get; set; }
    
    [Display(Name = "Is Graded")]
    public bool IsGraded { get; set; } = false;
    
    public ApplicationUser User { get; set; }
    public Assignment Assignment { get; set; }
}
