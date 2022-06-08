CREATE TABLE [settings].[CustomMetricSqlServers] (
    [CustomMetricId] BIGINT           NOT NULL,
    [SqlServerId]    UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [CustomMetricSqlServers_CustomMetricId_SqlServerId] PRIMARY KEY CLUSTERED ([CustomMetricId] ASC, [SqlServerId] ASC),
    CONSTRAINT [CustomMetricSqlServers_CustomMetrics] FOREIGN KEY ([CustomMetricId]) REFERENCES [settings].[CustomMetrics] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [CustomMetricSqlServers_SqlServers] FOREIGN KEY ([SqlServerId]) REFERENCES [settings].[SqlServers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [CustomMetricSqlServers_SqlServerId]
    ON [settings].[CustomMetricSqlServers]([SqlServerId] ASC);

