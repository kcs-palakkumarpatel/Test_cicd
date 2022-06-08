CREATE TYPE [data].[Cluster_SqlServer_QueryPlans_Sightings_Type] AS TABLE (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON));

