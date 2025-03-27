using System;

public class AssignmentFile
{
    public int Id { get; set; }
    public string FileName { get; set; }
    public string FilePath { get; set; }
    public int AssignmentId { get; set; }
    public DateTime UploadDate { get; set; } = DateTime.Now;
    public Assignment Assignment { get; set; }
}
