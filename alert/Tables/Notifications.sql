CREATE TABLE [alert].[Notifications] (
    [AlertId]          BIGINT NOT NULL,
    [SeverityDate]     BIGINT NOT NULL,
    [NotificationDate] BIGINT NOT NULL,
    [NotificationType] INT    NOT NULL,
    CONSTRAINT [Alert_Notifications_Idx] PRIMARY KEY CLUSTERED ([AlertId] ASC, [SeverityDate] ASC, [NotificationDate] ASC, [NotificationType] ASC),
    CONSTRAINT [Alert_Notifications_Severity] FOREIGN KEY ([AlertId], [SeverityDate]) REFERENCES [alert].[Alert_Severity] ([AlertId], [Date]) ON DELETE CASCADE
);

