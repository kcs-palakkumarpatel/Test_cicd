CREATE TABLE [settings].[CustomMetricAzureManagedInstances] (
    [CustomMetricId]         BIGINT           NOT NULL,
    [AzureManagedInstanceId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [CustomMetricAzureManagedInstances_CustomMetricId_AzureManagedInstanceId] PRIMARY KEY CLUSTERED ([CustomMetricId] ASC, [AzureManagedInstanceId] ASC),
    CONSTRAINT [CustomMetricAzureManagedInstances_AzureManagedInstances] FOREIGN KEY ([AzureManagedInstanceId]) REFERENCES [settings].[AzureManagedInstances] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [CustomMetricAzureManagedInstances_CustomMetrics] FOREIGN KEY ([CustomMetricId]) REFERENCES [settings].[CustomMetrics] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [CustomMetricAzureManagedInstances_AzureManagedInstanceId]
    ON [settings].[CustomMetricAzureManagedInstances]([AzureManagedInstanceId] ASC);

