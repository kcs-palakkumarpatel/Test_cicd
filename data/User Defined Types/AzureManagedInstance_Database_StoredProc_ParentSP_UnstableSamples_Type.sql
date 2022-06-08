CREATE TYPE [data].[AzureManagedInstance_Database_StoredProc_ParentSP_UnstableSamples_Type] AS TABLE (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_LastExecutionTime] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

