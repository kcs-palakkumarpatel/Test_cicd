CREATE TYPE [data].[AzureManagedInstance_Database_File_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_FileGroupName] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_FileName]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_GrowthBytes]   BIGINT         NULL,
    [_GrowthPercent] FLOAT (53)     NULL,
    [_MaxSize]       BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

