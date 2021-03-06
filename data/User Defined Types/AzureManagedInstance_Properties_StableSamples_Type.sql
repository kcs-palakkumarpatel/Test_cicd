CREATE TYPE [data].[AzureManagedInstance_Properties_StableSamples_Type] AS TABLE (
    [Id]                BIGINT         NOT NULL,
    [CollectionDate]    BIGINT         NOT NULL,
    [_Collation]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Edition]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_IsClustered]      BIT            NULL,
    [_IsSingleUser]     BIT            NULL,
    [_IsVirtualMachine] BIGINT         NULL,
    [_ProductLevel]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ProductVersion]   NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

