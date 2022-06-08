CREATE TABLE [settings].[CustomMetricClusters] (
    [CustomMetricId] BIGINT           NOT NULL,
    [ClusterId]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [CustomMetricClusters_CustomMetricId_ClusterId] PRIMARY KEY CLUSTERED ([CustomMetricId] ASC, [ClusterId] ASC),
    CONSTRAINT [CustomMetricClusters_Clusters] FOREIGN KEY ([ClusterId]) REFERENCES [settings].[Clusters] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [CustomMetricClusters_CustomMetrics] FOREIGN KEY ([CustomMetricId]) REFERENCES [settings].[CustomMetrics] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [CustomMetricClusters_ClusterId]
    ON [settings].[CustomMetricClusters]([ClusterId] ASC);

