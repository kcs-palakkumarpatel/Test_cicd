CREATE TABLE [data].[AzureManagedInstance_SqlText_Keys] (
    [Id]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_SqlHandle]     VARBINARY (900) NOT NULL,
    CONSTRAINT [AzureManagedInstance_SqlText_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_SqlText_Keys_AzureManagedInstance_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_SqlText_Keys_ParentId__SqlHandle] UNIQUE NONCLUSTERED ([ParentId] ASC, [_SqlHandle] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_SqlText_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_SqlText_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

