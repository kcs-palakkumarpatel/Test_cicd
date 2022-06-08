CREATE TABLE [settings].[CustomAlertDefinitions] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Description]    NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [CustomMetricId] BIGINT         NOT NULL,
    [Direction]      INT            NOT NULL,
    CONSTRAINT [CustomAlertDefinitions_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CustomAlertDefinitions_CustomMetric] FOREIGN KEY ([CustomMetricId]) REFERENCES [settings].[CustomMetrics] ([Id])
);

