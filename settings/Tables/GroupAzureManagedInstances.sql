CREATE TABLE [settings].[GroupAzureManagedInstances] (
    [GroupId]                UNIQUEIDENTIFIER NOT NULL,
    [AzureManagedInstanceId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [GroupAzureManagedInstances_GroupId_ServerId] PRIMARY KEY CLUSTERED ([GroupId] ASC, [AzureManagedInstanceId] ASC),
    CONSTRAINT [GroupAzureManagedInstances_Group] FOREIGN KEY ([GroupId]) REFERENCES [settings].[Group] ([GroupId]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupAzureManagedInstances_Servers] FOREIGN KEY ([AzureManagedInstanceId]) REFERENCES [settings].[AzureManagedInstances] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupAzureManagedInstances_ServerId] UNIQUE NONCLUSTERED ([AzureManagedInstanceId] ASC)
);

