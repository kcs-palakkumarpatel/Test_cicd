CREATE TABLE [data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_PlanHandle]    VARBINARY (MAX) NULL,
    CONSTRAINT [Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances_Cluster_SqlServer_Database_Table_MissingIndex_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys] ([Id]) ON DELETE CASCADE
);

