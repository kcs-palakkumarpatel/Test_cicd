CREATE TYPE [data].[Cluster_Machine_LogicalDisk_Volume_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_VolumePath]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

