CREATE TABLE [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys] (
    [Id]                  BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]            BIGINT         NOT NULL,
    [CollectionDate]      BIGINT         NOT NULL,
    [_DatabaseNameParent] NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Name]               NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AzureSqlServer_Database_StoredProcedure_ParentSP_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_StoredProcedure_ParentSP_Keys_AzureSqlServer_Database_StoredProcedure_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureSqlServer_Database_StoredProcedure_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureSqlServer_Database_StoredProcedure_ParentSP_Keys_ParentId__DatabaseNameParent__Name] UNIQUE NONCLUSTERED ([ParentId] ASC, [_DatabaseNameParent] ASC, [_Name] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureSqlServer_Database_StoredProcedure_ParentSP_Keys_CollectionDate]
    ON [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

