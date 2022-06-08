CREATE TYPE [data].[AzureManagedInstance_Latches_UnstableSamples_Type] AS TABLE (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_CumulativeLatchWaits]    BIGINT NULL,
    [_CumulativeLatchWaitTime] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

