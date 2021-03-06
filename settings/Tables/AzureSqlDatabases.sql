CREATE TABLE [settings].[AzureSqlDatabases] (
    [Id]                       UNIQUEIDENTIFIER NOT NULL,
    [CreatedDate]              BIGINT           NOT NULL,
    [ModifiedDate]             BIGINT           NOT NULL,
    [IsValid]                  BIT              NOT NULL,
    [IsSuspended]              BIT              NOT NULL,
    [CredentialsDiscriminator] INT              NOT NULL,
    [User]                     NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Domain]                   NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Password]                 NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [ParentId]                 UNIQUEIDENTIFIER NOT NULL,
    [Name]                     NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [IsTraceEnabled]           BIT              NOT NULL,
    [Port]                     INT              NULL,
    [NetworkLibrary]           NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [PacketSize]               INT              NULL,
    [ConnectionTimeout]        INT              NULL,
    [ExecutionTimeout]         INT              NULL,
    [Encrypt]                  BIT              NOT NULL,
    [Alias]                    NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [RequestedLicenceLevel]    INT              NOT NULL,
    [EffectiveLicenceLevel]    INT              NOT NULL,
    CONSTRAINT [AzureSqlDatabases_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [AzureSqlDatabases_Clusters] FOREIGN KEY ([ParentId]) REFERENCES [settings].[AzureSqlServers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureSqlDatabases_ParentId_Name] UNIQUE NONCLUSTERED ([ParentId] ASC, [Name] ASC)
);

