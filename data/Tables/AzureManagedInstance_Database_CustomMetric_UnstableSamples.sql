CREATE TABLE [data].[AzureManagedInstance_Database_CustomMetric_UnstableSamples] (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Value]         FLOAT (53) NULL,
    CONSTRAINT [AzureManagedInstance_Database_CustomMetric_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_CustomMetric_UnstableSamples_AzureManagedInstance_Database_CustomMetric_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_CustomMetric_Keys] ([Id]) ON DELETE CASCADE
);

