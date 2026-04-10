using ElementaryBridgeApp.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace ElementaryBridgeApp.Data;

public class ElementaryDbContext : DbContext
{
    public ElementaryDbContext(DbContextOptions<ElementaryDbContext> options)
        : base(options)
    {
    }

    public DbSet<ToolSlotConfiguration> ToolSlotConfigurations => Set<ToolSlotConfiguration>();

    public DbSet<ToolSlotConfigurationAudit> ToolSlotConfigurationAudits => Set<ToolSlotConfigurationAudit>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ToolSlotConfiguration>(entity =>
        {
            // The audit trigger dbo.trg_ToolSlotConfigurations_Audit must be
            // declared to EF Core so it falls back to a trigger-safe save
            // pattern (no OUTPUT ... without INTO). Without this, SaveChanges
            // fails with: "The target table 'dbo.ToolSlotConfigurations' of
            // the DML statement cannot have any enabled triggers if the
            // statement contains an OUTPUT clause without INTO clause."
            entity.ToTable(
                "ToolSlotConfigurations",
                "dbo",
                t => t.HasTrigger("trg_ToolSlotConfigurations_Audit"));
            entity.HasKey(x => x.CID);
            entity.Property(x => x.CID).UseIdentityColumn();
            entity.Property(x => x.IsActive).HasDefaultValue(true);
        });

        modelBuilder.Entity<ToolSlotConfigurationAudit>(entity =>
        {
            entity.ToTable("ToolSlotConfigurationAudit", "dbo");
            entity.HasKey(x => x.AuditId);
            entity.Property(x => x.AuditId).UseIdentityColumn();
            entity.Property(x => x.FieldName).HasMaxLength(128).IsRequired();
            entity.Property(x => x.User).HasColumnName("User").HasMaxLength(256).IsRequired();
        });
    }
}
