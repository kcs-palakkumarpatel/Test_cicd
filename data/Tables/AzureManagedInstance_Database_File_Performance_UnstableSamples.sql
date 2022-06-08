CREATE TABLE [data].[AzureManagedInstance_Database_File_Performance_UnstableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativeReadBytes]      BIGINT NULL,
    [_CumulativeReadStalls]     BIGINT NULL,
    [_CumulativeReadStallTime]  BIGINT NULL,
    [_CumulativeWriteBytes]     BIGINT NULL,
    [_CumulativeWriteStalls]    BIGINT NULL,
    [_CumulativeWriteStallTime] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Database_File_Performance_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_File_Performance_UnstableSamples_AzureManagedInstance_Database_File_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_File_Keys] ([Id]) ON DELETE CASCADE
);

