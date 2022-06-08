CREATE PROCEDURE [data].[AzureManagedInstance_SqlText_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_SqlText_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_SqlText_Keys]

DELETE [data].[AzureManagedInstance_SqlText_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_SqlText_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION