﻿CREATE TYPE [data].[Cluster_SqlServer_Agent_Job_Schedule_StableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_NextRunDate]   BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));
