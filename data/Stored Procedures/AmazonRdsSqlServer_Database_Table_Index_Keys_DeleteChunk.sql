CREATE PROCEDURE [data].[AmazonRdsSqlServer_Database_Table_Index_Keys_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([Id])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_Database_Table_Index_Keys]
OUTPUT deleted.[Id] INTO @Chunk
FROM [#AmazonRdsSqlServer_Database_Table_Index_Keys]

DELETE [data].[AmazonRdsSqlServer_Database_Table_Index_Keys]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Index_Keys] d ON c.[Id] = d.[Id]

COMMIT TRANSACTION