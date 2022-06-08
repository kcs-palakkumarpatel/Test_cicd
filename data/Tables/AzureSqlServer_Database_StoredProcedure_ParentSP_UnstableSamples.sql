CREATE TABLE [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_LastExecutionTime] BIGINT NULL,
    CONSTRAINT [AzureSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples_AzureSqlServer_Database_StoredProcedure_ParentSP_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys] ([Id]) ON DELETE CASCADE
);

