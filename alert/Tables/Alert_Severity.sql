CREATE TABLE [alert].[Alert_Severity] (
    [AlertId]  BIGINT NOT NULL,
    [Date]     BIGINT NOT NULL,
    [Severity] INT    NULL,
    CONSTRAINT [Alert_Severity_AlertId_Date] PRIMARY KEY CLUSTERED ([AlertId] ASC, [Date] ASC),
    CONSTRAINT [Alert_Severity_Alert] FOREIGN KEY ([AlertId]) REFERENCES [alert].[Alert] ([AlertId]) ON DELETE CASCADE
);

