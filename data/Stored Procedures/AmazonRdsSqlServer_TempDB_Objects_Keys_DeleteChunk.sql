CREATE PROCEDURE [data].[AmazonRdsSqlServer_TempDB_Objects_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_TempDB_Objects_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AmazonRdsSqlServer_TempDB_Objects_Keys]

DELETE [data].[AmazonRdsSqlServer_TempDB_Objects_Keys]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Objects_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION