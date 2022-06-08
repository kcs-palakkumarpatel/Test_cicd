﻿CREATE TABLE [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys] (
    [Id]                 BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]           BIGINT         NOT NULL,
    [CollectionDate]     BIGINT         NOT NULL,
    [_EqualityColumns]   NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_IncludedColumns]   NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_InequalityColumns] NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AzureManagedInstance_Database_Table_MissingIndex_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_Table_MissingIndex_Keys_AzureManagedInstance_Database_Table_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Database_Table_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_Database_Table_MissingIndex_Keys_ParentId__EqualityColumns__IncludedColumns__InequalityColumns] UNIQUE NONCLUSTERED ([ParentId] ASC, [_EqualityColumns] ASC, [_IncludedColumns] ASC, [_InequalityColumns] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_Database_Table_MissingIndex_Keys_CollectionDate]
    ON [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

