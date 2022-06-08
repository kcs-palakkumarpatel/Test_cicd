CREATE PROCEDURE [data].[AzureManagedInstance_SqlProcess_UnstableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_SqlProcess_UnstableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AzureManagedInstance_SqlProcess_UnstableSamples]

DELETE [data].[AzureManagedInstance_SqlProcess_UnstableSamples]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_SqlProcess_UnstableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION