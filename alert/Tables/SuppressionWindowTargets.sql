CREATE TABLE [alert].[SuppressionWindowTargets] (
    [AlertSuppressionWindowId] INT              NOT NULL,
    [TargetEntityId]           UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_SuppressionWindowTargets] PRIMARY KEY CLUSTERED ([AlertSuppressionWindowId] ASC, [TargetEntityId] ASC),
    CONSTRAINT [SuppressionWindowTargets_CheckTargetExists] CHECK ([alert].[CheckSuppressionTargetExists]([TargetEntityId])=(1)),
    CONSTRAINT [SuppressionWindowTargets_AlertSuppressionWindows] FOREIGN KEY ([AlertSuppressionWindowId]) REFERENCES [alert].[SuppressionWindows] ([Id]) ON DELETE CASCADE
);

