CREATE TYPE [data].[Cluster_SqlServer_Agent_Job_StableSamples_Type] AS TABLE (
    [Id]                  BIGINT           NOT NULL,
    [CollectionDate]      BIGINT           NOT NULL,
    [_CategoryName]       NVARCHAR (MAX)   COLLATE Latin1_General_BIN2 NULL,
    [_DatabaseNameOrNone] NVARCHAR (MAX)   COLLATE Latin1_General_BIN2 NULL,
    [_DateModified]       BIGINT           NULL,
    [_Description]        NVARCHAR (MAX)   COLLATE Latin1_General_BIN2 NULL,
    [_Enabled]            BIT              NULL,
    [_JobId]              UNIQUEIDENTIFIER NULL,
    [_Owner]              NVARCHAR (MAX)   COLLATE Latin1_General_BIN2 NULL,
    [_OwnerSid]           NVARCHAR (MAX)   COLLATE Latin1_General_BIN2 NULL,
    [_VersionNumber]      BIGINT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

