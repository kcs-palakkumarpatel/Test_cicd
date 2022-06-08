CREATE TABLE [data].[AmazonRdsSqlServer_Error_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_ProcessInfo]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Text]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_Error_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Error_Instances_AmazonRdsSqlServer_Error_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Error_Keys] ([Id]) ON DELETE CASCADE
);

