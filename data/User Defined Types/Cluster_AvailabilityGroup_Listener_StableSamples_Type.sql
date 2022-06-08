CREATE TYPE [data].[Cluster_AvailabilityGroup_Listener_StableSamples_Type] AS TABLE (
    [Id]                 BIGINT         NOT NULL,
    [CollectionDate]     BIGINT         NOT NULL,
    [_ListenerIpAddress] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ListenerPort]      BIGINT         NULL,
    [_ListenerState]     BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

