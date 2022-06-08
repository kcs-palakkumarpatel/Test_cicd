CREATE TABLE [data].[AzureSqlServer_Database_ExtendedEvents_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_EventName]     NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Sequence]      BIGINT         NOT NULL,
    [_TimeStamp]     BIGINT         NOT NULL,
    CONSTRAINT [AzureSqlServer_Database_ExtendedEvents_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_ExtendedEvents_Keys_AzureSqlServer_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureSqlServer_Database_ExtendedEvents_Keys_ParentId__EventName__Sequence__TimeStamp] UNIQUE NONCLUSTERED ([ParentId] ASC, [_EventName] ASC, [_Sequence] ASC, [_TimeStamp] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureSqlServer_Database_ExtendedEvents_Keys_CollectionDate]
    ON [data].[AzureSqlServer_Database_ExtendedEvents_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

