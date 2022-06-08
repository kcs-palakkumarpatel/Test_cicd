CREATE TABLE [data].[AzureSqlServer_Database_QueryPlans_Instances] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_DatabaseName]  NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_PlanHash]      VARBINARY (MAX) NULL,
    [_QueryPlan]     NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureSqlServer_Database_QueryPlans_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_QueryPlans_Instances_AzureSqlServer_Database_QueryPlans_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_QueryPlans_Keys] ([Id]) ON DELETE CASCADE
);

