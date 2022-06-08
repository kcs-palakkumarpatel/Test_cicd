CREATE TYPE [data].[AzureManagedInstance_Database_Table_Index_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Fragmentation] FLOAT (53) NULL,
    [_Pages]         BIGINT     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

