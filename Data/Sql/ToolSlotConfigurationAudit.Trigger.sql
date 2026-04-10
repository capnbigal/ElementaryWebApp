-- AFTER INSERT, UPDATE trigger: writes one audit row per tracked field
-- per row, but only when the field value actually changed.
--
-- Uses a LEFT JOIN to "deleted" so INSERTs (which have no matching
-- deleted row) are audited alongside UPDATEs. On INSERT, d.* is NULL,
-- so the explicit null-safe inequality in each WHERE clause emits an
-- audit row for every inserted field whose value is not NULL, plus
-- IsActive (which is NOT NULL on the source table and therefore always
-- "differs" from the NULL "old value" synthesized by the LEFT JOIN).
-- On UPDATE, both sides are populated and only fields that actually
-- differ produce audit rows. Handles multi-row DML as a set.
--
-- Null-safe inequality pattern used throughout:
--     (i.Col IS NULL AND d.Col IS NOT NULL)
--  OR (i.Col IS NOT NULL AND d.Col IS NULL)
--  OR (i.Col <> d.Col)
--
-- Re-run this script after any schema change to ToolSlotConfigurations
-- to keep the trigger in sync.

CREATE OR ALTER TRIGGER dbo.trg_ToolSlotConfigurations_Audit
ON dbo.ToolSlotConfigurations
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM inserted) RETURN;

    DECLARE @EditDate DATETIME2(3)  = SYSUTCDATETIME();
    DECLARE @User     NVARCHAR(256) = SUSER_SNAME();

    -- FAMILY
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FAMILY', d.FAMILY, i.FAMILY, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FAMILY IS NULL     AND d.FAMILY IS NOT NULL)
       OR (i.FAMILY IS NOT NULL AND d.FAMILY IS NULL)
       OR (i.FAMILY <> d.FAMILY);

    -- MT_CODE
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'MT_CODE', d.MT_CODE, i.MT_CODE, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.MT_CODE IS NULL     AND d.MT_CODE IS NOT NULL)
       OR (i.MT_CODE IS NOT NULL AND d.MT_CODE IS NULL)
       OR (i.MT_CODE <> d.MT_CODE);

    -- DESTINATION
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'DESTINATION', d.DESTINATION, i.DESTINATION, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.DESTINATION IS NULL     AND d.DESTINATION IS NOT NULL)
       OR (i.DESTINATION IS NOT NULL AND d.DESTINATION IS NULL)
       OR (i.DESTINATION <> d.DESTINATION);

    -- FCL1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FCL1', d.FCL1, i.FCL1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FCL1 IS NULL     AND d.FCL1 IS NOT NULL)
       OR (i.FCL1 IS NOT NULL AND d.FCL1 IS NULL)
       OR (i.FCL1 <> d.FCL1);

    -- FCL2
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FCL2', d.FCL2, i.FCL2, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FCL2 IS NULL     AND d.FCL2 IS NOT NULL)
       OR (i.FCL2 IS NOT NULL AND d.FCL2 IS NULL)
       OR (i.FCL2 <> d.FCL2);

    -- FCR1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FCR1', d.FCR1, i.FCR1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FCR1 IS NULL     AND d.FCR1 IS NOT NULL)
       OR (i.FCR1 IS NOT NULL AND d.FCR1 IS NULL)
       OR (i.FCR1 <> d.FCR1);

    -- FFL1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FFL1', d.FFL1, i.FFL1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FFL1 IS NULL     AND d.FFL1 IS NOT NULL)
       OR (i.FFL1 IS NOT NULL AND d.FFL1 IS NULL)
       OR (i.FFL1 <> d.FFL1);

    -- FFL2
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FFL2', d.FFL2, i.FFL2, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FFL2 IS NULL     AND d.FFL2 IS NOT NULL)
       OR (i.FFL2 IS NOT NULL AND d.FFL2 IS NULL)
       OR (i.FFL2 <> d.FFL2);

    -- FFR1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FFR1', d.FFR1, i.FFR1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FFR1 IS NULL     AND d.FFR1 IS NOT NULL)
       OR (i.FFR1 IS NOT NULL AND d.FFR1 IS NULL)
       OR (i.FFR1 <> d.FFR1);

    -- FFR2
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FFR2', d.FFR2, i.FFR2, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FFR2 IS NULL     AND d.FFR2 IS NOT NULL)
       OR (i.FFR2 IS NOT NULL AND d.FFR2 IS NULL)
       OR (i.FFR2 <> d.FFR2);

    -- FFR3
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FFR3', d.FFR3, i.FFR3, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FFR3 IS NULL     AND d.FFR3 IS NOT NULL)
       OR (i.FFR3 IS NOT NULL AND d.FFR3 IS NULL)
       OR (i.FFR3 <> d.FFR3);

    -- FFR4
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'FFR4', d.FFR4, i.FFR4, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.FFR4 IS NULL     AND d.FFR4 IS NOT NULL)
       OR (i.FFR4 IS NOT NULL AND d.FFR4 IS NULL)
       OR (i.FFR4 <> d.FFR4);

    -- RCL1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'RCL1', d.RCL1, i.RCL1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.RCL1 IS NULL     AND d.RCL1 IS NOT NULL)
       OR (i.RCL1 IS NOT NULL AND d.RCL1 IS NULL)
       OR (i.RCL1 <> d.RCL1);

    -- RCR1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'RCR1', d.RCR1, i.RCR1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.RCR1 IS NULL     AND d.RCR1 IS NOT NULL)
       OR (i.RCR1 IS NOT NULL AND d.RCR1 IS NULL)
       OR (i.RCR1 <> d.RCR1);

    -- RCR2
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'RCR2', d.RCR2, i.RCR2, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.RCR2 IS NULL     AND d.RCR2 IS NOT NULL)
       OR (i.RCR2 IS NOT NULL AND d.RCR2 IS NULL)
       OR (i.RCR2 <> d.RCR2);

    -- RFL1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'RFL1', d.RFL1, i.RFL1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.RFL1 IS NULL     AND d.RFL1 IS NOT NULL)
       OR (i.RFL1 IS NOT NULL AND d.RFL1 IS NULL)
       OR (i.RFL1 <> d.RFL1);

    -- RFR1
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'RFR1', d.RFR1, i.RFR1, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.RFR1 IS NULL     AND d.RFR1 IS NOT NULL)
       OR (i.RFR1 IS NOT NULL AND d.RFR1 IS NULL)
       OR (i.RFR1 <> d.RFR1);

    -- RFR2
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID, N'RFR2', d.RFR2, i.RFR2, @EditDate, @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.RFR2 IS NULL     AND d.RFR2 IS NOT NULL)
       OR (i.RFR2 IS NOT NULL AND d.RFR2 IS NULL)
       OR (i.RFR2 <> d.RFR2);

    -- IsActive (NOT NULL on source; on INSERT d.IsActive is NULL from LEFT JOIN)
    INSERT INTO dbo.ToolSlotConfigurationAudit (CID, FieldName, OldValue, NewValue, EditDate, [User])
    SELECT i.CID,
           N'IsActive',
           CAST(d.IsActive AS NVARCHAR(5)),
           CAST(i.IsActive AS NVARCHAR(5)),
           @EditDate,
           @User
    FROM inserted i LEFT JOIN deleted d ON d.CID = i.CID
    WHERE (i.IsActive IS NULL     AND d.IsActive IS NOT NULL)
       OR (i.IsActive IS NOT NULL AND d.IsActive IS NULL)
       OR (i.IsActive <> d.IsActive);
END
GO
