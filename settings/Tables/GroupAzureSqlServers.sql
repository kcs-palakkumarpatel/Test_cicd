CREATE TABLE [settings].[GroupAzureSqlServers] (
    [GroupId]          UNIQUEIDENTIFIER NOT NULL,
    [AzureSqlServerId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [GroupAzureSqlServers_GroupId_ServerId] PRIMARY KEY CLUSTERED ([GroupId] ASC, [AzureSqlServerId] ASC),
    CONSTRAINT [GroupAzureSqlServers_Group] FOREIGN KEY ([GroupId]) REFERENCES [settings].[Group] ([GroupId]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupAzureSqlServers_Servers] FOREIGN KEY ([AzureSqlServerId]) REFERENCES [settings].[AzureSqlServers] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupAzureSqlServers_ServerId] UNIQUE NONCLUSTERED ([AzureSqlServerId] ASC)
);

