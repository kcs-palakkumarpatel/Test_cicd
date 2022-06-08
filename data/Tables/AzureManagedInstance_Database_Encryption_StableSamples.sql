CREATE TABLE [data].[AzureManagedInstance_Database_Encryption_StableSamples] (
    [Id]               BIGINT         NOT NULL,
    [CollectionDate]   BIGINT         NOT NULL,
    [_EncryptionState] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureManagedInstance_Database_Encryption_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_Encryption_StableSamples_AzureManagedInstance_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_Keys] ([Id]) ON DELETE CASCADE
);

