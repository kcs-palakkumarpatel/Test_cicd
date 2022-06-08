CREATE TABLE [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings] (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings_SightingDate_Id] PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings_AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings_Id]
    ON [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings]([Id] ASC, [SightingDate] ASC) WITH (DATA_COMPRESSION = PAGE);

