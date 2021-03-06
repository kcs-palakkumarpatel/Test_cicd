CREATE TABLE [data].[AmazonRdsSqlServer_Agent_Job_StableSamples] (
    [Id]                  BIGINT         NOT NULL,
    [CollectionDate]      BIGINT         NOT NULL,
    [_CategoryName]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_DatabaseNameOrNone] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_DateModified]       BIGINT         NULL,
    [_Description]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Enabled]            BIT            NULL,
    [_Owner]              NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_OwnerSid]           NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_VersionNumber]      BIGINT         NULL,
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_StableSamples_AmazonRdsSqlServer_Agent_Job_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Agent_Job_Keys] ([Id]) ON DELETE CASCADE
);

