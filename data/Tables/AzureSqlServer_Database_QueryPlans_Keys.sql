﻿CREATE TABLE [data].[AzureSqlServer_Database_QueryPlans_Keys] (
    [Id]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_CreateDate]    BIGINT          NOT NULL,
    [_PlanHandle]    VARBINARY (900) NOT NULL,
    CONSTRAINT [AzureSqlServer_Database_QueryPlans_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_QueryPlans_Keys_AzureSqlServer_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureSqlServer_Database_QueryPlans_Keys_ParentId__CreateDate__PlanHandle] UNIQUE NONCLUSTERED ([ParentId] ASC, [_CreateDate] ASC, [_PlanHandle] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureSqlServer_Database_QueryPlans_Keys_CollectionDate]
    ON [data].[AzureSqlServer_Database_QueryPlans_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

