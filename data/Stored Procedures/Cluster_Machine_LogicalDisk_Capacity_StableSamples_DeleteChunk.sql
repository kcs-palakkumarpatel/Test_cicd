CREATE PROCEDURE [data].[Cluster_Machine_LogicalDisk_Capacity_StableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#Cluster_Machine_LogicalDisk_Capacity_StableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#Cluster_Machine_LogicalDisk_Capacity_StableSamples]

DELETE [data].[Cluster_Machine_LogicalDisk_Capacity_StableSamples]
FROM @Chunk c
INNER JOIN [data].[Cluster_Machine_LogicalDisk_Capacity_StableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION