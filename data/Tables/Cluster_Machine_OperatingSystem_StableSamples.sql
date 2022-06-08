CREATE TABLE [data].[Cluster_Machine_OperatingSystem_StableSamples] (
    [Id]              BIGINT         NOT NULL,
    [CollectionDate]  BIGINT         NOT NULL,
    [_BuildNumber]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Caption]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_LastBootUpTime] BIGINT         NULL,
    [_ServicePack]    NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    [_Version]        NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_Machine_OperatingSystem_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_OperatingSystem_StableSamples_Cluster_Machine_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE
);

