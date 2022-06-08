CREATE TABLE [settings].[SnmpTargets] (
    [Id]              INT            IDENTITY (1, 1) NOT NULL,
    [Server]          NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Port]            INT            NOT NULL,
    [CommunityString] NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [SnmpTargets_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

