CREATE TABLE [data].[AmazonRdsSqlServer_SqlProcess_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Hostname]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_LoginName]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ProgramName]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_SqlProcess_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_SqlProcess_Instances_AmazonRdsSqlServer_SqlProcess_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_SqlProcess_Keys] ([Id]) ON DELETE CASCADE
);

