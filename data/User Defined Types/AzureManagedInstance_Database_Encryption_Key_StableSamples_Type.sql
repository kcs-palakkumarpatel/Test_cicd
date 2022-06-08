CREATE TYPE [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples_Type] AS TABLE (
    [Id]              BIGINT         NOT NULL,
    [CollectionDate]  BIGINT         NOT NULL,
    [_Algorithm]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_EncryptionType] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Name]           NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

