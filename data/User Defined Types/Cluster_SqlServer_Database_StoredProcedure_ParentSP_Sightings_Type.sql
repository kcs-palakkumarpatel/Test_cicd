﻿CREATE TYPE [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings_Type] AS TABLE (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON));

