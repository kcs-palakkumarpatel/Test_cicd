CREATE PROCEDURE [data].[AzureManagedInstance_QueryPlans_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_QueryPlans_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_QueryPlans_Keys]

DELETE [data].[AzureManagedInstance_QueryPlans_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_QueryPlans_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION