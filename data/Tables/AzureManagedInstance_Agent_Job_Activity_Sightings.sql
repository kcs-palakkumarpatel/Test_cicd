CREATE TABLE [data].[AzureManagedInstance_Agent_Job_Activity_Sightings] (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    CONSTRAINT [AzureManagedInstance_Agent_Job_Activity_Sightings_SightingDate_Id] PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Agent_Job_Activity_Sightings_AzureManagedInstance_Agent_Job_Activity_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Agent_Job_Activity_Keys] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_Agent_Job_Activity_Sightings_Id]
    ON [data].[AzureManagedInstance_Agent_Job_Activity_Sightings]([Id] ASC, [SightingDate] ASC) WITH (DATA_COMPRESSION = PAGE);

