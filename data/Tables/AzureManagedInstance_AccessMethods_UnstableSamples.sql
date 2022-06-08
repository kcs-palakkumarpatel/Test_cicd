CREATE TABLE [data].[AzureManagedInstance_AccessMethods_UnstableSamples] (
    [Id]                    BIGINT NOT NULL,
    [CollectionDate]        BIGINT NOT NULL,
    [_CumulativeFullScans]  BIGINT NULL,
    [_CumulativePageSplits] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_AccessMethods_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_AccessMethods_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

