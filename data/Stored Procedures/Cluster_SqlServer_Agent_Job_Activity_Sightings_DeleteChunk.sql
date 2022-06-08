﻿CREATE PROCEDURE [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [SightingDate] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([SightingDate], [Id])
)

DELETE TOP (@ChunkSize) [#Cluster_SqlServer_Agent_Job_Activity_Sightings]
OUTPUT deleted.[SightingDate], deleted.[Id] INTO @Chunk
FROM [#Cluster_SqlServer_Agent_Job_Activity_Sightings]

DELETE [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings]
FROM @Chunk c
INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings] d ON c.[SightingDate] = d.[SightingDate] AND c.[Id] = d.[Id]

COMMIT TRANSACTION