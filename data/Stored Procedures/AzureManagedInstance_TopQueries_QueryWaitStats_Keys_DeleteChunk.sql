CREATE PROCEDURE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_TopQueries_QueryWaitStats_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_TopQueries_QueryWaitStats_Keys]

DELETE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION