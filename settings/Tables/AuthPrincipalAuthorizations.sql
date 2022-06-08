CREATE TABLE [settings].[AuthPrincipalAuthorizations] (
    [AuthorizationId]        INT              IDENTITY (1, 1) NOT NULL,
    [AuthPrincipalsId]       INT              NOT NULL,
    [GroupId]                UNIQUEIDENTIFIER NULL,
    [ClusterId]              UNIQUEIDENTIFIER NULL,
    [AzureSqlServerId]       UNIQUEIDENTIFIER NULL,
    [AzureManagedInstanceId] UNIQUEIDENTIFIER NULL,
    [AmazonRdsSqlServerId]   UNIQUEIDENTIFIER NULL,
    CONSTRAINT [AuthPrincipalAuthorizations_PK] PRIMARY KEY CLUSTERED ([AuthorizationId] ASC),
    CONSTRAINT [FK__AuthPrincipalAuthorizations__AmazonRdsSqlServer] FOREIGN KEY ([AmazonRdsSqlServerId]) REFERENCES [settings].[AmazonRdsSqlServers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK__AuthPrincipalAuthorizations__AzureManagedInstance] FOREIGN KEY ([AzureManagedInstanceId]) REFERENCES [settings].[AzureManagedInstances] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK__AuthPrincipalAuthorizations__AzureSqlServer] FOREIGN KEY ([AzureSqlServerId]) REFERENCES [settings].[AzureSqlServers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK__AuthPrincipalAuthorizations__Cluster] FOREIGN KEY ([ClusterId]) REFERENCES [settings].[Clusters] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK__AuthPrincipalAuthorizations__Group] FOREIGN KEY ([GroupId]) REFERENCES [settings].[Group] ([GroupId]) ON DELETE CASCADE,
    CONSTRAINT [FK__AuthPrincipalAuthorizations__Principal] FOREIGN KEY ([AuthPrincipalsId]) REFERENCES [settings].[AuthPrincipals] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AuthPrincipalAuthorizations_Uniqueness] UNIQUE NONCLUSTERED ([AuthPrincipalsId] ASC, [GroupId] ASC, [ClusterId] ASC, [AzureSqlServerId] ASC, [AzureManagedInstanceId] ASC, [AmazonRdsSqlServerId] ASC)
);

