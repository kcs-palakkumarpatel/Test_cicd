CREATE TABLE [data].[AzureManagedInstance_Database_File_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_FileGroupName] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_FileName]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_GrowthBytes]   BIGINT         NULL,
    [_GrowthPercent] FLOAT (53)     NULL,
    [_MaxSize]       BIGINT         NULL,
    CONSTRAINT [AzureManagedInstance_Database_File_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_File_StableSamples_AzureManagedInstance_Database_File_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_File_Keys] ([Id]) ON DELETE CASCADE
);

