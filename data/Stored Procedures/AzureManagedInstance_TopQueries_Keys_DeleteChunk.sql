CREATE PROCEDURE [data].[AzureManagedInstance_TopQueries_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_TopQueries_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_TopQueries_Keys]

DELETE [data].[AzureManagedInstance_TopQueries_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_TopQueries_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION