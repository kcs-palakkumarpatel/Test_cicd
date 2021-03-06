CREATE PROCEDURE [data].[AzureManagedInstance_SqlProcess_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_SqlProcess_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_SqlProcess_Keys]

DELETE [data].[AzureManagedInstance_SqlProcess_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_SqlProcess_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION