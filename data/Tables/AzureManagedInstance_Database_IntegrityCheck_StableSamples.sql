﻿CREATE TABLE [data].[AzureManagedInstance_Database_IntegrityCheck_StableSamples] (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_LastIntegrityCheck] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Database_IntegrityCheck_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_IntegrityCheck_StableSamples_AzureManagedInstance_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_Keys] ([Id]) ON DELETE CASCADE
);

