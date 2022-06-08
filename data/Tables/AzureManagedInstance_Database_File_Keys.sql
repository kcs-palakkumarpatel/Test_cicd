CREATE TABLE [data].[AzureManagedInstance_Database_File_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Type]          BIGINT         NOT NULL,
    CONSTRAINT [AzureManagedInstance_Database_File_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_File_Keys_AzureManagedInstance_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_Database_File_Keys_ParentId__Name__Type] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Name] ASC, [_Type] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_Database_File_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_Database_File_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

