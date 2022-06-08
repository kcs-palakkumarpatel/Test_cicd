CREATE TABLE [data].[AmazonRdsSqlServer_SqlText_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_SqlText]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_SqlText_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_SqlText_Instances_AmazonRdsSqlServer_SqlText_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_SqlText_Keys] ([Id]) ON DELETE CASCADE
);

