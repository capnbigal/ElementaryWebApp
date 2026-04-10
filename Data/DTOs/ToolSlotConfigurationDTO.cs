using System.ComponentModel.DataAnnotations;

namespace ElementaryBridgeApp.Data.DTOs;

public class ToolSlotConfigurationDTO
{
    public int CID { get; set; }

    [Required(ErrorMessage = "FAMILY is required.")]
    public string? FAMILY { get; set; }

    [Required(ErrorMessage = "MT_CODE is required.")]
    public string? MT_CODE { get; set; }

    [Required(ErrorMessage = "DESTINATION is required.")]
    public string? DESTINATION { get; set; }

    public string? FCL1 { get; set; }
    public string? FCL2 { get; set; }
    public string? FCR1 { get; set; }
    public string? FFL1 { get; set; }
    public string? FFL2 { get; set; }
    public string? FFR1 { get; set; }
    public string? FFR2 { get; set; }
    public string? FFR3 { get; set; }
    public string? FFR4 { get; set; }
    public string? RCL1 { get; set; }
    public string? RCR1 { get; set; }
    public string? RCR2 { get; set; }
    public string? RFL1 { get; set; }
    public string? RFR1 { get; set; }
    public string? RFR2 { get; set; }
    public bool IsActive { get; set; } = true;
}
