CREATE TABLE [settings].[UserAccount] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [UserName]     NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [PasswordHash] NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [UserAccount_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UserAccount_UserName] UNIQUE NONCLUSTERED ([UserName] ASC)
);

