CREATE TABLE [data].[Cluster_SqlServer_SqlText_Instances] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_QueryHash]     VARBINARY (MAX) NULL,
    [_SqlText]       NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_SqlServer_SqlText_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_SqlText_Instances_Cluster_SqlServer_SqlText_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_SqlText_Keys] ([Id]) ON DELETE CASCADE
);

