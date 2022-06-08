CREATE TABLE [data].[AzureManagedInstance_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AzureManagedInstance_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Keys__Name] UNIQUE NONCLUSTERED ([_Name] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

