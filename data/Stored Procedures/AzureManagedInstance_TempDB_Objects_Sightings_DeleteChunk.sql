CREATE PROCEDURE [data].[AzureManagedInstance_TempDB_Objects_Sightings_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [SightingDate] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([SightingDate], [Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_TempDB_Objects_Sightings]
OUTPUT deleted.[SightingDate], deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_TempDB_Objects_Sightings]

DELETE [data].[AzureManagedInstance_TempDB_Objects_Sightings]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_TempDB_Objects_Sightings] d ON c.[SightingDate] = d.[SightingDate] AND c.[Id] = d.[Id]

COMMIT TRANSACTION