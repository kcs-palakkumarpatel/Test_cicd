CREATE TABLE [alert].[Alert] (
    [AlertId]       BIGINT         NOT NULL,
    [AlertType]     BIGINT         NOT NULL,
    [TargetObject]  NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [Read]          AS             (CONVERT([bit],case when [ReadDate] IS NULL then (0) else (1) end,(0))) PERSISTED,
    [ReadDate]      BIGINT         NULL,
    [SubType]       BIGINT         CONSTRAINT [Alert_SubType_DF] DEFAULT ((0)) NOT NULL,
    [LastUpdate]    BIGINT         NOT NULL,
    [Raised]        BIGINT         NOT NULL,
    [LastSeverity]  INT            NOT NULL,
    [WorstSeverity] INT            NOT NULL,
    [Cleared]       AS             (CONVERT([bit],case when [ClearedDate] IS NULL then (0) else (1) end,(0))) PERSISTED,
    [ClearedDate]   BIGINT         NULL,
    [LastComment]   NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [RootCir]       NVARCHAR (450) COLLATE Latin1_General_BIN2 NULL,
    [GroupCir]      NVARCHAR (450) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Alert_AlertId] PRIMARY KEY CLUSTERED ([AlertId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Alert_Type]
    ON [alert].[Alert]([AlertType] ASC);


GO
CREATE NONCLUSTERED INDEX [Alert_AlertType_ClearedDate_LastUpdate_TargetObject]
    ON [alert].[Alert]([AlertType] ASC, [ClearedDate] ASC, [LastUpdate] ASC, [TargetObject] ASC)
    INCLUDE([LastSeverity], [SubType], [WorstSeverity]);


GO
CREATE NONCLUSTERED INDEX [Alert_AlertType_ClearedDate_ReadDate_TargetObject]
    ON [alert].[Alert]([AlertType] ASC, [ClearedDate] ASC, [ReadDate] ASC, [TargetObject] ASC)
    INCLUDE([LastSeverity], [LastUpdate], [SubType], [WorstSeverity]);


GO
CREATE NONCLUSTERED INDEX [GroupCir_Read]
    ON [alert].[Alert]([GroupCir] ASC, [Read] ASC);


GO
CREATE NONCLUSTERED INDEX [Alert_TargetObject]
    ON [alert].[Alert]([TargetObject] ASC);

