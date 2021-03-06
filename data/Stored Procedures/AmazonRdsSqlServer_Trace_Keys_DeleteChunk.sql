CREATE PROCEDURE [data].[AmazonRdsSqlServer_Trace_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_Trace_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AmazonRdsSqlServer_Trace_Keys]

DELETE [data].[AmazonRdsSqlServer_Trace_Keys]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_Trace_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION