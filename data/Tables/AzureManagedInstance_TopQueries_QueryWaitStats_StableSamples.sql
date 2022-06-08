CREATE TABLE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_LoginName]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ProgramName]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples_AzureManagedInstance_TopQueries_QueryWaitStats_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys] ([Id]) ON DELETE CASCADE
);

