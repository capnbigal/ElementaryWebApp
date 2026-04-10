namespace ElementaryBridgeApp.Data.DTOs;

public class ToolSlotConfigurationAuditDTO
{
    public long AuditId { get; set; }
    public int CID { get; set; }
    public string FieldName { get; set; } = string.Empty;
    public string? OldValue { get; set; }
    public string? NewValue { get; set; }
    public DateTime EditDate { get; set; }
    public string User { get; set; } = string.Empty;
}
