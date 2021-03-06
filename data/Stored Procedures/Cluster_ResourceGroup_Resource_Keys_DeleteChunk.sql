CREATE PROCEDURE [data].[Cluster_ResourceGroup_Resource_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#Cluster_ResourceGroup_Resource_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#Cluster_ResourceGroup_Resource_Keys]

DELETE [data].[Cluster_ResourceGroup_Resource_Keys]
FROM @Chunk c
INNER JOIN [data].[Cluster_ResourceGroup_Resource_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION