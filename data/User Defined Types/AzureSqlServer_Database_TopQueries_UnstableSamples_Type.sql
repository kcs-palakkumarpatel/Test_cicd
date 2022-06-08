CREATE TYPE [data].[AzureSqlServer_Database_TopQueries_UnstableSamples_Type] AS TABLE (
    [Id]              BIGINT NOT NULL,
    [CollectionDate]  BIGINT NOT NULL,
    [_ExecutionCount] BIGINT NULL,
    [_ExecutionTime]  BIGINT NULL,
    [_LogicalReads]   BIGINT NULL,
    [_LogicalWrites]  BIGINT NULL,
    [_PhysicalReads]  BIGINT NULL,
    [_WorkerTime]     BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

