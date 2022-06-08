CREATE TABLE [settings].[CustomMetricGroups] (
    [CustomMetricId] BIGINT           NOT NULL,
    [GroupId]        UNIQUEIDENTIFIER NULL,
    CONSTRAINT [CustomMetricGroups_CustomMetrics] FOREIGN KEY ([CustomMetricId]) REFERENCES [settings].[CustomMetrics] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [CustomMetricGroups_Groups] FOREIGN KEY ([GroupId]) REFERENCES [settings].[Group] ([GroupId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [CustomMetricGroups_CustomMetricId]
    ON [settings].[CustomMetricGroups]([CustomMetricId] ASC);


GO
CREATE NONCLUSTERED INDEX [CustomMetricGroups_GroupId]
    ON [settings].[CustomMetricGroups]([GroupId] ASC);

