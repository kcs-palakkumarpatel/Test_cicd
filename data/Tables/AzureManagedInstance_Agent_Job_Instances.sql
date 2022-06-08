CREATE TABLE [data].[AzureManagedInstance_Agent_Job_Instances] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_DateCreated]   BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Agent_Job_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Agent_Job_Instances_AzureManagedInstance_Agent_Job_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Agent_Job_Keys] ([Id]) ON DELETE CASCADE
);

