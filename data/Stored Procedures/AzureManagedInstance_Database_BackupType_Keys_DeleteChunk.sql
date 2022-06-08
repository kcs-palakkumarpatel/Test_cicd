CREATE PROCEDURE [data].[AzureManagedInstance_Database_BackupType_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_Database_BackupType_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_Database_BackupType_Keys]

DELETE [data].[AzureManagedInstance_Database_BackupType_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_Database_BackupType_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION