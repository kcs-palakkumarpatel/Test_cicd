CREATE TABLE [settings].[Machines] (
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
    CONSTRAINT [Machines_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [Machines_Clusters] FOREIGN KEY ([ParentId]) REFERENCES [settings].[Clusters] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Machines_ParentId_Name] UNIQUE NONCLUSTERED ([ParentId] ASC, [Name] ASC)
);

