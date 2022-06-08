CREATE TABLE [data].[AzureManagedInstance_Database_Table_MissingIndex_Plans_Instances] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_PlanHandle]    VARBINARY (MAX) NULL,
    CONSTRAINT [AzureManagedInstance_Database_Table_MissingIndex_Plans_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_Table_MissingIndex_Plans_Instances_AzureManagedInstance_Database_Table_MissingIndex_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys] ([Id]) ON DELETE CASCADE
);

