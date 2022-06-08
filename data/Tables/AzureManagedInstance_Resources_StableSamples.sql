CREATE TABLE [data].[AzureManagedInstance_Resources_StableSamples] (
    [Id]                     BIGINT         NOT NULL,
    [CollectionDate]         BIGINT         NOT NULL,
    [_HardwareGeneration]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ReservedStorageBytes]  BIGINT         NULL,
    [_ResourceName]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ResourceType]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Sku]                   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_StorageSpaceUsedBytes] BIGINT         NULL,
    [_VirtualCoreCount]      BIGINT         NULL,
    CONSTRAINT [AzureManagedInstance_Resources_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Resources_StableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

