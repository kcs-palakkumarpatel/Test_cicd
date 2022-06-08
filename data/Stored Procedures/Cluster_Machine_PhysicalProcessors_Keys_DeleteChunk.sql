﻿CREATE PROCEDURE [data].[Cluster_Machine_PhysicalProcessors_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#Cluster_Machine_PhysicalProcessors_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#Cluster_Machine_PhysicalProcessors_Keys]

DELETE [data].[Cluster_Machine_PhysicalProcessors_Keys]
FROM @Chunk c
INNER JOIN [data].[Cluster_Machine_PhysicalProcessors_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION