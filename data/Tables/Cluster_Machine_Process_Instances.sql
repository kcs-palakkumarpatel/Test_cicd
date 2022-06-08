CREATE TABLE [data].[Cluster_Machine_Process_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_Machine_Process_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_Process_Instances_Cluster_Machine_Process_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Process_Keys] ([Id]) ON DELETE CASCADE
);

