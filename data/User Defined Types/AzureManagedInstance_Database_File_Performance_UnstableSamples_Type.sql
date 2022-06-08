CREATE TYPE [data].[AzureManagedInstance_Database_File_Performance_UnstableSamples_Type] AS TABLE (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativeReadBytes]      BIGINT NULL,
    [_CumulativeReadStalls]     BIGINT NULL,
    [_CumulativeReadStallTime]  BIGINT NULL,
    [_CumulativeWriteBytes]     BIGINT NULL,
    [_CumulativeWriteStalls]    BIGINT NULL,
    [_CumulativeWriteStallTime] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

