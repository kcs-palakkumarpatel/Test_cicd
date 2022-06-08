CREATE PROCEDURE [data].[AzureManagedInstance_ServerWaits_UnstableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_ServerWaits_UnstableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AzureManagedInstance_ServerWaits_UnstableSamples]

DELETE [data].[AzureManagedInstance_ServerWaits_UnstableSamples]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_ServerWaits_UnstableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION