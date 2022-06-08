CREATE TABLE [settings].[CustomMetricAzureSqlServers] (
    [CustomMetricId]   BIGINT           NOT NULL,
    [AzureSqlServerId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [CustomMetricAzureSqlServers_CustomMetricId_SqlServerId] PRIMARY KEY CLUSTERED ([CustomMetricId] ASC, [AzureSqlServerId] ASC),
    CONSTRAINT [CustomMetricAzureSqlServers_CustomMetrics] FOREIGN KEY ([CustomMetricId]) REFERENCES [settings].[CustomMetrics] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [CustomMetricAzureSqlServers_SqlServers] FOREIGN KEY ([AzureSqlServerId]) REFERENCES [settings].[AzureSqlServers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [CustomMetricAzureSqlServers_SqlServerId]
    ON [settings].[CustomMetricAzureSqlServers]([AzureSqlServerId] ASC);

