CREATE TABLE [settings].[AuthTokens] (
    [Id]           INT             IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (100)  COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [HashSalt]     NVARCHAR (MAX)  COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [HashedToken]  VARBINARY (MAX) NOT NULL,
    [Username]     NVARCHAR (100)  COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [CreatedAtUtc] DATETIME2 (7)   NOT NULL,
    CONSTRAINT [PK_AuthTokens] PRIMARY KEY CLUSTERED ([Id] ASC)
);

