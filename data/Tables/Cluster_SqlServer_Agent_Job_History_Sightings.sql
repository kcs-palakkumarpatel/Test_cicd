CREATE TABLE [data].[Cluster_SqlServer_Agent_Job_History_Sightings] (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    CONSTRAINT [Cluster_SqlServer_Agent_Job_History_Sightings_SightingDate_Id] PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Agent_Job_History_Sightings_Cluster_SqlServer_Agent_Job_History_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Agent_Job_History_Keys] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_Agent_Job_History_Sightings_Id]
    ON [data].[Cluster_SqlServer_Agent_Job_History_Sightings]([Id] ASC, [SightingDate] ASC) WITH (DATA_COMPRESSION = PAGE);

