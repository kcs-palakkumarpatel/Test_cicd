CREATE TABLE [settings].[GroupAmazonRdsSqlServers] (
    [GroupId]              UNIQUEIDENTIFIER NOT NULL,
    [AmazonRdsSqlServerId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [GroupAmazonRdsSqlServers_GroupId_ServerId] PRIMARY KEY CLUSTERED ([GroupId] ASC, [AmazonRdsSqlServerId] ASC),
    CONSTRAINT [GroupAmazonRdsSqlServers_Group] FOREIGN KEY ([GroupId]) REFERENCES [settings].[Group] ([GroupId]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupAmazonRdsSqlServers_Servers] FOREIGN KEY ([AmazonRdsSqlServerId]) REFERENCES [settings].[AmazonRdsSqlServers] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupAmazonRdsSqlServers_ServerId] UNIQUE NONCLUSTERED ([AmazonRdsSqlServerId] ASC)
);

