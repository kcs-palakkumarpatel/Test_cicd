CREATE TABLE [data].[AzureManagedInstance_GeneralStatistics_UnstableSamples] (
    [Id]               BIGINT NOT NULL,
    [CollectionDate]   BIGINT NOT NULL,
    [_UserConnections] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_GeneralStatistics_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_GeneralStatistics_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

