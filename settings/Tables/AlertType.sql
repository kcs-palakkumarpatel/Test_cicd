CREATE TABLE [settings].[AlertType] (
    [Filter]          BIGINT         NOT NULL,
    [AlertType]       BIGINT         NOT NULL,
    [SubType]         BIGINT         CONSTRAINT [AlertType_SubType_DF] DEFAULT ((0)) NOT NULL,
    [BaseMonitorName] NVARCHAR (200) COLLATE Latin1_General_CS_AS_KS_WS CONSTRAINT [AlertType_BaseMonitorName_DF] DEFAULT ('') NOT NULL,
    CONSTRAINT [AlertType_Filter_AlertType_SubType] PRIMARY KEY CLUSTERED ([Filter] ASC, [AlertType] ASC, [SubType] ASC, [BaseMonitorName] ASC),
    CONSTRAINT [AlertType_InboxSavedFilter] FOREIGN KEY ([Filter]) REFERENCES [settings].[InboxSavedFilter] ([Id])
);

