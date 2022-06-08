CREATE TYPE [data].[AzureManagedInstance_Resources_StableSamples_Type] AS TABLE (
    [Id]                     BIGINT         NOT NULL,
    [CollectionDate]         BIGINT         NOT NULL,
    [_HardwareGeneration]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ReservedStorageBytes]  BIGINT         NULL,
    [_ResourceName]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ResourceType]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Sku]                   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_StorageSpaceUsedBytes] BIGINT         NULL,
    [_VirtualCoreCount]      BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

