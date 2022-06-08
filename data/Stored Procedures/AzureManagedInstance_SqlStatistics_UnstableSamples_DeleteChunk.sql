CREATE PROCEDURE [data].[AzureManagedInstance_SqlStatistics_UnstableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_SqlStatistics_UnstableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AzureManagedInstance_SqlStatistics_UnstableSamples]

DELETE [data].[AzureManagedInstance_SqlStatistics_UnstableSamples]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_SqlStatistics_UnstableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION