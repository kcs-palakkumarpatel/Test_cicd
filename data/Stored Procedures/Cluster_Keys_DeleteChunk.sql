CREATE PROCEDURE [data].[Cluster_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#Cluster_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#Cluster_Keys]

DELETE [data].[Cluster_Keys]
FROM @Chunk c
INNER JOIN [data].[Cluster_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION