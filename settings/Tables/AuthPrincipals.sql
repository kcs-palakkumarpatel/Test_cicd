CREATE TABLE [settings].[AuthPrincipals] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Name]               NVARCHAR (255) COLLATE Latin1_General_BIN2 NOT NULL,
    [PrincipalType]      INT            NOT NULL,
    [PrincipalRole]      INT            NOT NULL,
    [All]                BIT            NOT NULL,
    [AuthenticationType] INT            NOT NULL,
    CONSTRAINT [AuthPrincipals_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_AuthPrincipals__Name__AuthenticationType] UNIQUE NONCLUSTERED ([Name] ASC, [AuthenticationType] ASC)
);

