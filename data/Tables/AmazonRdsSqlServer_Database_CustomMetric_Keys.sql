CREATE TABLE [data].[AmazonRdsSqlServer_Database_CustomMetric_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_MetricId]      BIGINT NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_CustomMetric_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_CustomMetric_Keys_AmazonRdsSqlServer_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Database_CustomMetric_Keys_ParentId__MetricId] UNIQUE NONCLUSTERED ([ParentId] ASC, [_MetricId] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Database_CustomMetric_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_Database_CustomMetric_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

