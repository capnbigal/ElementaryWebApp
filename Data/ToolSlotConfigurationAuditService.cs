using ElementaryBridgeApp.Data.DTOs;
using ElementaryBridgeApp.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace ElementaryBridgeApp.Data;

public class ToolSlotConfigurationAuditService
{
    private readonly IDbContextFactory<ElementaryDbContext> _factory;

    public ToolSlotConfigurationAuditService(IDbContextFactory<ElementaryDbContext> factory)
    {
        _factory = factory;
    }

    public async Task<List<ToolSlotConfigurationAuditDTO>> GetAllAsync(CancellationToken ct = default)
    {
        await using var db = await _factory.CreateDbContextAsync(ct);
        var rows = await db.ToolSlotConfigurationAudits
            .AsNoTracking()
            .OrderByDescending(x => x.EditDate)
            .ThenByDescending(x => x.AuditId)
            .ToListAsync(ct);
        return rows.Select(MapToDto).ToList();
    }

    private static ToolSlotConfigurationAuditDTO MapToDto(ToolSlotConfigurationAudit e) => new()
    {
        AuditId = e.AuditId,
        CID = e.CID,
        FieldName = e.FieldName,
        OldValue = e.OldValue,
        NewValue = e.NewValue,
        EditDate = e.EditDate,
        User = e.User
    };
}
