CREATE TABLE [data].[Cluster_SqlServer_Database_File_Performance_UnstableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativeReadBytes]      BIGINT NULL,
    [_CumulativeReadStalls]     BIGINT NULL,
    [_CumulativeReadStallTime]  BIGINT NULL,
    [_CumulativeWriteBytes]     BIGINT NULL,
    [_CumulativeWriteStalls]    BIGINT NULL,
    [_CumulativeWriteStallTime] BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_File_Performance_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_File_Performance_UnstableSamples_Cluster_SqlServer_Database_File_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_File_Keys] ([Id]) ON DELETE CASCADE
);

