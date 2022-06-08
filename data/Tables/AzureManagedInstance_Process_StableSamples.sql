CREATE TABLE [data].[AzureManagedInstance_Process_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Id]            BIGINT         NULL,
    [_Name]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_StartDate]     BIGINT         NULL,
    CONSTRAINT [AzureManagedInstance_Process_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Process_StableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

