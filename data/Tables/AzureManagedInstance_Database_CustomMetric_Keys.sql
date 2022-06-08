CREATE TABLE [data].[AzureManagedInstance_Database_CustomMetric_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_MetricId]      BIGINT NOT NULL,
    CONSTRAINT [AzureManagedInstance_Database_CustomMetric_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_CustomMetric_Keys_AzureManagedInstance_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_Database_CustomMetric_Keys_ParentId__MetricId] UNIQUE NONCLUSTERED ([ParentId] ASC, [_MetricId] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_Database_CustomMetric_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_Database_CustomMetric_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

