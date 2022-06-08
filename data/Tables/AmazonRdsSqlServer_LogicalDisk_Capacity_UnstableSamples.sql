﻿CREATE TABLE [data].[AmazonRdsSqlServer_LogicalDisk_Capacity_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_UsedBytes]     BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_LogicalDisk_Capacity_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_LogicalDisk_Capacity_UnstableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

