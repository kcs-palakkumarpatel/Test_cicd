﻿CREATE PROCEDURE [data].[Cluster_SqlServer_Database_File_UnstableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#Cluster_SqlServer_Database_File_UnstableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#Cluster_SqlServer_Database_File_UnstableSamples]

DELETE [data].[Cluster_SqlServer_Database_File_UnstableSamples]
FROM @Chunk c
INNER JOIN [data].[Cluster_SqlServer_Database_File_UnstableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION