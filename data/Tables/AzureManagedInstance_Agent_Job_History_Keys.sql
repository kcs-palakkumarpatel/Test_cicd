CREATE TABLE [data].[AzureManagedInstance_Agent_Job_History_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_Id]            BIGINT NOT NULL,
    [_RunDate]       BIGINT NOT NULL,
    CONSTRAINT [AzureManagedInstance_Agent_Job_History_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Agent_Job_History_Keys_AzureManagedInstance_Agent_Job_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Agent_Job_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_Agent_Job_History_Keys_ParentId__RunDate__Id] UNIQUE NONCLUSTERED ([ParentId] ASC, [_RunDate] ASC, [_Id] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_Agent_Job_History_Keys__RunDate]
    ON [data].[AzureManagedInstance_Agent_Job_History_Keys]([_RunDate] ASC) WITH (DATA_COMPRESSION = PAGE);

