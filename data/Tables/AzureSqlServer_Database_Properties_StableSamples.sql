CREATE TABLE [data].[AzureSqlServer_Database_Properties_StableSamples] (
    [Id]                      BIGINT         NOT NULL,
    [CollectionDate]          BIGINT         NOT NULL,
    [_Collation]              NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_CompatibilityLevel]     BIGINT         NULL,
    [_CreateDate]             BIGINT         NULL,
    [_Edition]                NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_IsAutoCreateStatistics] BIT            NULL,
    [_IsAutoShrink]           BIT            NULL,
    [_IsAutoUpdateStatistics] BIT            NULL,
    [_IsQueryStore]           BIT            NULL,
    [_IsReadOnly]             BIT            NULL,
    [_IsSingleUser]           BIT            NULL,
    [_Owner]                  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_PageVerify]             NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ProductLevel]           NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ProductVersion]         NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    [_State]                  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureSqlServer_Database_Properties_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_Properties_StableSamples_AzureSqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

