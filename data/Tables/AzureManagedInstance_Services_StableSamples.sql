CREATE TABLE [data].[AzureManagedInstance_Services_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_ServiceState]  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Startup]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureManagedInstance_Services_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Services_StableSamples_AzureManagedInstance_Services_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Services_Keys] ([Id]) ON DELETE CASCADE
);

