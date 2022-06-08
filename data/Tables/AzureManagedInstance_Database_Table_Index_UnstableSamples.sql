﻿CREATE TABLE [data].[AzureManagedInstance_Database_Table_Index_UnstableSamples] (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Fragmentation] FLOAT (53) NULL,
    [_Pages]         BIGINT     NULL,
    CONSTRAINT [AzureManagedInstance_Database_Table_Index_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_Table_Index_UnstableSamples_AzureManagedInstance_Database_Table_Index_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_Table_Index_Keys] ([Id]) ON DELETE CASCADE
);

