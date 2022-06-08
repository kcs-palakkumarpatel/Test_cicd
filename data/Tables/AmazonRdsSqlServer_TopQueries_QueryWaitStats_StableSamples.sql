CREATE TABLE [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_LoginName]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ProgramName]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_StableSamples_AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] ([Id]) ON DELETE CASCADE
);

