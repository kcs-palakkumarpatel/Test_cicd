CREATE TABLE [data].[AmazonRdsSqlServer_TopQueries_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_ObjectName]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_QueryText]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_Instances_AmazonRdsSqlServer_TopQueries_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_TopQueries_Keys] ([Id]) ON DELETE CASCADE
);

