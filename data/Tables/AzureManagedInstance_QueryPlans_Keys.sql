CREATE TABLE [data].[AzureManagedInstance_QueryPlans_Keys] (
    [Id]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_CreateDate]    BIGINT          NOT NULL,
    [_PlanHandle]    VARBINARY (900) NOT NULL,
    CONSTRAINT [AzureManagedInstance_QueryPlans_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_QueryPlans_Keys_AzureManagedInstance_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_QueryPlans_Keys_ParentId__CreateDate__PlanHandle] UNIQUE NONCLUSTERED ([ParentId] ASC, [_CreateDate] ASC, [_PlanHandle] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_QueryPlans_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_QueryPlans_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

