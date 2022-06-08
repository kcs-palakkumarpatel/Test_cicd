CREATE TYPE [data].[AzureManagedInstance_Process_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Id]            BIGINT         NULL,
    [_Name]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_StartDate]     BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

