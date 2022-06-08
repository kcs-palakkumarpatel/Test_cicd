CREATE TABLE [data].[Cluster_AvailabilityGroup_Replica_Info_Instances] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_IsFci]         BIT    NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Info_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Info_Instances_Cluster_AvailabilityGroup_Replica_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_AvailabilityGroup_Replica_Keys] ([Id]) ON DELETE CASCADE
);

