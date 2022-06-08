CREATE TABLE [data].[AzureManagedInstance_SqlText_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_SqlText]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureManagedInstance_SqlText_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_SqlText_Instances_AzureManagedInstance_SqlText_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_SqlText_Keys] ([Id]) ON DELETE CASCADE
);

