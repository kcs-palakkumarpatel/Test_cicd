CREATE TABLE [data].[AmazonRdsSqlServer_Properties_StableSamples] (
    [Id]                BIGINT         NOT NULL,
    [CollectionDate]    BIGINT         NOT NULL,
    [_Collation]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Edition]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_IsClustered]      BIT            NULL,
    [_IsSingleUser]     BIT            NULL,
    [_IsVirtualMachine] BIGINT         NULL,
    [_ProductLevel]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ProductVersion]   NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_Properties_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Properties_StableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

