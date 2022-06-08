CREATE TABLE [settings].[CustomMetricAmazonRdsSqlServers] (
    [CustomMetricId]       BIGINT           NOT NULL,
    [AmazonRdsSqlServerId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [CustomMetricAmazonRdsSqlServers_CustomMetricId_SqlServerId] PRIMARY KEY CLUSTERED ([CustomMetricId] ASC, [AmazonRdsSqlServerId] ASC),
    CONSTRAINT [CustomMetricAmazonRdsSqlServers_CustomMetrics] FOREIGN KEY ([CustomMetricId]) REFERENCES [settings].[CustomMetrics] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [CustomMetricAmazonRdsSqlServers_SqlServers] FOREIGN KEY ([AmazonRdsSqlServerId]) REFERENCES [settings].[AmazonRdsSqlServers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [CustomMetricAmazonRdsSqlServers_SqlServerId]
    ON [settings].[CustomMetricAmazonRdsSqlServers]([AmazonRdsSqlServerId] ASC);

