CREATE TABLE [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Plans_Instances] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_PlanHandle]    VARBINARY (MAX) NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_MissingIndex_Plans_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_MissingIndex_Plans_Instances_AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] ([Id]) ON DELETE CASCADE
);

