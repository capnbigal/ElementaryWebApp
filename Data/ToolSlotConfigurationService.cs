using ElementaryBridgeApp.Data.DTOs;
using ElementaryBridgeApp.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace ElementaryBridgeApp.Data;

public class ToolSlotConfigurationService
{
    private readonly IDbContextFactory<ElementaryDbContext> _factory;

    public ToolSlotConfigurationService(IDbContextFactory<ElementaryDbContext> factory)
    {
        _factory = factory;
    }

    public async Task<List<ToolSlotConfigurationDTO>> GetAllAsync(CancellationToken ct = default)
    {
        await using var db = await _factory.CreateDbContextAsync(ct);
        var rows = await db.ToolSlotConfigurations
            .AsNoTracking()
            .OrderBy(x => x.CID)
            .ToListAsync(ct);
        return rows.Select(MapToDto).ToList();
    }

    public async Task<bool> UpdateAsync(ToolSlotConfigurationDTO dto, CancellationToken ct = default)
    {
        await using var db = await _factory.CreateDbContextAsync(ct);
        var entity = await db.ToolSlotConfigurations.FirstOrDefaultAsync(x => x.CID == dto.CID, ct);
        if (entity is null)
            return false;

        ApplyDto(entity, dto);
        await db.SaveChangesAsync(ct);
        return true;
    }

    public async Task<ToolSlotConfigurationDTO> CreateAsync(ToolSlotConfigurationDTO dto, CancellationToken ct = default)
    {
        await using var db = await _factory.CreateDbContextAsync(ct);
        var entity = new ToolSlotConfiguration();
        ApplyDto(entity, dto);
        db.ToolSlotConfigurations.Add(entity);
        await db.SaveChangesAsync(ct);
        return MapToDto(entity);
    }

    private static ToolSlotConfigurationDTO MapToDto(ToolSlotConfiguration e) => new()
    {
        CID = e.CID,
        FAMILY = e.FAMILY,
        MT_CODE = e.MT_CODE,
        DESTINATION = e.DESTINATION,
        FCL1 = e.FCL1,
        FCL2 = e.FCL2,
        FCR1 = e.FCR1,
        FFL1 = e.FFL1,
        FFL2 = e.FFL2,
        FFR1 = e.FFR1,
        FFR2 = e.FFR2,
        FFR3 = e.FFR3,
        FFR4 = e.FFR4,
        RCL1 = e.RCL1,
        RCR1 = e.RCR1,
        RCR2 = e.RCR2,
        RFL1 = e.RFL1,
        RFR1 = e.RFR1,
        RFR2 = e.RFR2,
        IsActive = e.IsActive
    };

    private static void ApplyDto(ToolSlotConfiguration e, ToolSlotConfigurationDTO d)
    {
        e.FAMILY = d.FAMILY;
        e.MT_CODE = d.MT_CODE;
        e.DESTINATION = d.DESTINATION;
        e.FCL1 = d.FCL1;
        e.FCL2 = d.FCL2;
        e.FCR1 = d.FCR1;
        e.FFL1 = d.FFL1;
        e.FFL2 = d.FFL2;
        e.FFR1 = d.FFR1;
        e.FFR2 = d.FFR2;
        e.FFR3 = d.FFR3;
        e.FFR4 = d.FFR4;
        e.RCL1 = d.RCL1;
        e.RCR1 = d.RCR1;
        e.RCR2 = d.RCR2;
        e.RFL1 = d.RFL1;
        e.RFR1 = d.RFR1;
        e.RFR2 = d.RFR2;
        e.IsActive = d.IsActive;
    }
}
