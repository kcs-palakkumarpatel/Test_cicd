CREATE TABLE [data].[Cluster_SqlServer_QueryPlans_Instances] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_DatabaseName]  NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_PlanHash]      VARBINARY (MAX) NULL,
    [_QueryPlan]     NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_SqlServer_QueryPlans_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_QueryPlans_Instances_Cluster_SqlServer_QueryPlans_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_QueryPlans_Keys] ([Id]) ON DELETE CASCADE
);

