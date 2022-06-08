CREATE PROCEDURE [data].[AzureManagedInstance_Agent_Job_Activity_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_Agent_Job_Activity_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_Agent_Job_Activity_Keys]

DELETE [data].[AzureManagedInstance_Agent_Job_Activity_Keys]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_Agent_Job_Activity_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION