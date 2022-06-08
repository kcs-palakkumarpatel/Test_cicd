CREATE TYPE [data].[AzureManagedInstance_Database_Storage_UnstableSamples_Type] AS TABLE (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_TotalDataUsedBytes] BIGINT NULL,
    [_TotalLogUsedBytes]  BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

