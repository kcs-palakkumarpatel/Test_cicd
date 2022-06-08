CREATE TABLE [data].[AzureManagedInstance_TopQueries_StableSamples] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_CreateDate]    BIGINT          NULL,
    [_PlanHandle]    VARBINARY (MAX) NULL,
    [_QueryHash]     VARBINARY (MAX) NULL,
    [_QueryPlanHash] VARBINARY (MAX) NULL,
    CONSTRAINT [AzureManagedInstance_TopQueries_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_TopQueries_StableSamples_AzureManagedInstance_TopQueries_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_TopQueries_Keys] ([Id]) ON DELETE CASCADE
);

