CREATE TABLE [data].[AzureManagedInstance_TraceFlags_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_TraceFlag]     BIGINT NOT NULL,
    CONSTRAINT [AzureManagedInstance_TraceFlags_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_TraceFlags_Keys_AzureManagedInstance_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_TraceFlags_Keys_ParentId__TraceFlag] UNIQUE NONCLUSTERED ([ParentId] ASC, [_TraceFlag] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_TraceFlags_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_TraceFlags_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

