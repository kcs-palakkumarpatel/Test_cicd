CREATE TABLE [data].[AzureManagedInstance_ConfigurationOptions_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AzureManagedInstance_ConfigurationOptions_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_ConfigurationOptions_Keys_AzureManagedInstance_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_ConfigurationOptions_Keys_ParentId__Name] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Name] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_ConfigurationOptions_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_ConfigurationOptions_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

