CREATE TABLE [data].[AzureManagedInstance_Trace_Instances] (
    [Id]               BIGINT         NOT NULL,
    [CollectionDate]   BIGINT         NOT NULL,
    [_ApplicationName] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_DatabaseName]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_HostName]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_LoginName]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Spid]            BIGINT         NULL,
    [_TextData]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureManagedInstance_Trace_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Trace_Instances_AzureManagedInstance_Trace_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Trace_Keys] ([Id]) ON DELETE CASCADE
);

