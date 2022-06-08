﻿CREATE TABLE [data].[AzureManagedInstance_Database_StoredProc_ParentSP_UnstableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_LastExecutionTime] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Database_StoredProc_ParentSP_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_StoredProc_ParentSP_UnstableSamples_AzureManagedInstance_Database_StoredProc_ParentSP_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys] ([Id]) ON DELETE CASCADE
);

