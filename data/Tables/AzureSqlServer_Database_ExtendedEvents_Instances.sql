CREATE TABLE [data].[AzureSqlServer_Database_ExtendedEvents_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_EventData]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_FileName]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_FileOffset]    BIGINT         NULL,
    CONSTRAINT [AzureSqlServer_Database_ExtendedEvents_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_ExtendedEvents_Instances_AzureSqlServer_Database_ExtendedEvents_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_ExtendedEvents_Keys] ([Id]) ON DELETE CASCADE
);

