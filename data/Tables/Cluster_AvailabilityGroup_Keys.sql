CREATE TABLE [data].[Cluster_AvailabilityGroup_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Keys_Cluster_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_AvailabilityGroup_Keys_ParentId__Name] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Name] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_AvailabilityGroup_Keys_CollectionDate]
    ON [data].[Cluster_AvailabilityGroup_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

