CREATE TYPE [data].[AmazonRdsSqlServer_Database_File_Projection_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Gradient]      FLOAT (53) NULL,
    [_Intercept]     FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

