CREATE TYPE [data].[Cluster_Machine_OperatingSystem_StableSamples_Type] AS TABLE (
    [Id]              BIGINT         NOT NULL,
    [CollectionDate]  BIGINT         NOT NULL,
    [_BuildNumber]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Caption]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_LastBootUpTime] BIGINT         NULL,
    [_ServicePack]    NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    [_Version]        NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

