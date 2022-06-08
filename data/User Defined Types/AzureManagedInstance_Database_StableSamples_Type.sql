CREATE TYPE [data].[AzureManagedInstance_Database_StableSamples_Type] AS TABLE (
    [Id]                    BIGINT         NOT NULL,
    [CollectionDate]        BIGINT         NOT NULL,
    [_AutoCreateStatistics] BIT            NULL,
    [_AutoShrink]           BIT            NULL,
    [_Collation]            NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_CompatibilityLevel]   BIGINT         NULL,
    [_CreateDate]           BIGINT         NULL,
    [_DatabaseId]           BIGINT         NULL,
    [_Owner]                NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_PageVerify]           NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ReadOnly]             BIT            NULL,
    [_RecoveryModel]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Standby]              BIT            NULL,
    [_State]                NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

