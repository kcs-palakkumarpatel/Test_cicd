CREATE PROCEDURE [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_Agent_Job_Schedule_StableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AzureManagedInstance_Agent_Job_Schedule_StableSamples]

DELETE [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION