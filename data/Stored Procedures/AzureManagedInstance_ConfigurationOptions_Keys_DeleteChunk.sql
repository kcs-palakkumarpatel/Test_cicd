CREATE PROCEDURE [data].[AzureManagedInstance_ConfigurationOptions_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_ConfigurationOptions_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_ConfigurationOptions_Keys]

DELETE [data].[AzureManagedInstance_ConfigurationOptions_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_ConfigurationOptions_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION