﻿CREATE PROCEDURE [data].[AzureSqlServer_Database_GeneralStatistics_UnstableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AzureSqlServer_Database_GeneralStatistics_UnstableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AzureSqlServer_Database_GeneralStatistics_UnstableSamples]

DELETE [data].[AzureSqlServer_Database_GeneralStatistics_UnstableSamples]
FROM @Chunk c
INNER JOIN [data].[AzureSqlServer_Database_GeneralStatistics_UnstableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION