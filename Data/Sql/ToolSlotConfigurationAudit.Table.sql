-- Audit table for dbo.ToolSlotConfigurations.
-- Written by the AFTER UPDATE trigger dbo.trg_ToolSlotConfigurations_Audit.
-- One row per tracked field that actually changed on an UPDATE.

IF OBJECT_ID(N'dbo.ToolSlotConfigurationAudit', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ToolSlotConfigurationAudit
    (
        AuditId    BIGINT         IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_ToolSlotConfigurationAudit PRIMARY KEY,
        CID        INT            NOT NULL,
        FieldName  NVARCHAR(128)  NOT NULL,
        OldValue   NVARCHAR(MAX)  NULL,
        NewValue   NVARCHAR(MAX)  NULL,
        EditDate   DATETIME2(3)   NOT NULL
            CONSTRAINT DF_ToolSlotConfigurationAudit_EditDate DEFAULT SYSUTCDATETIME(),
        [User]     NVARCHAR(256)  NOT NULL
            CONSTRAINT DF_ToolSlotConfigurationAudit_User     DEFAULT SUSER_SNAME()
    );

    CREATE INDEX IX_ToolSlotConfigurationAudit_CID
        ON dbo.ToolSlotConfigurationAudit (CID);

    CREATE INDEX IX_ToolSlotConfigurationAudit_EditDate
        ON dbo.ToolSlotConfigurationAudit (EditDate DESC);
END
GO
