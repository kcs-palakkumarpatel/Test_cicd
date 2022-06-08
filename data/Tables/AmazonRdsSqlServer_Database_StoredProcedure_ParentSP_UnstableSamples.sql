CREATE TABLE [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_LastExecutionTime] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples_AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys] ([Id]) ON DELETE CASCADE
);

