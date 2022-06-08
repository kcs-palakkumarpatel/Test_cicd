﻿CREATE TABLE [data].[AzureManagedInstance_SqlProcess_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_LoginTime]     BIGINT NOT NULL,
    [_SessionId]     BIGINT NOT NULL,
    CONSTRAINT [AzureManagedInstance_SqlProcess_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_SqlProcess_Keys_AzureManagedInstance_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_SqlProcess_Keys_ParentId__LoginTime__SessionId] UNIQUE NONCLUSTERED ([ParentId] ASC, [_LoginTime] ASC, [_SessionId] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_SqlProcess_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_SqlProcess_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

