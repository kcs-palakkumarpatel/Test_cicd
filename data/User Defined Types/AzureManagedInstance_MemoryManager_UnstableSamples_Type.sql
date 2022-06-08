CREATE TYPE [data].[AzureManagedInstance_MemoryManager_UnstableSamples_Type] AS TABLE (
    [Id]                           BIGINT NOT NULL,
    [CollectionDate]               BIGINT NOT NULL,
    [_ConnectionMemoryBytes]       BIGINT NULL,
    [_DatabaseCacheMemoryBytes]    BIGINT NULL,
    [_FreeMemoryBytes]             BIGINT NULL,
    [_LockMemoryBytes]             BIGINT NULL,
    [_LogPoolMemoryBytes]          BIGINT NULL,
    [_MaximumWorkspaceMemoryBytes] BIGINT NULL,
    [_MemoryGrantsPending]         BIGINT NULL,
    [_OptimizerMemoryBytes]        BIGINT NULL,
    [_PlanCacheMemoryBytes]        BIGINT NULL,
    [_ReservedMemoryBytes]         BIGINT NULL,
    [_StolenServerMemoryBytes]     BIGINT NULL,
    [_TargetServerMemoryBytes]     BIGINT NULL,
    [_TotalServerMemoryBytes]      BIGINT NULL,
    [_WorkspaceMemoryBytes]        BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

