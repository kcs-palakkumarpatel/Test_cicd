CREATE TABLE [data].[Cluster_SqlServer_Agent_Job_Schedule_StableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_NextRunDate]   BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_Agent_Job_Schedule_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Agent_Job_Schedule_StableSamples_Cluster_SqlServer_Agent_Job_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Agent_Job_Keys] ([Id]) ON DELETE CASCADE
);

