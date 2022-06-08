CREATE TABLE [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_NextRunDate]   BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Agent_Job_Schedule_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Agent_Job_Schedule_StableSamples_AzureManagedInstance_Agent_Job_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Agent_Job_Keys] ([Id]) ON DELETE CASCADE
);

