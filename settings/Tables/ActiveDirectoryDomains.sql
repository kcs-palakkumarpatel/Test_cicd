CREATE TABLE [settings].[ActiveDirectoryDomains] (
    [Domain] NVARCHAR (255) COLLATE Latin1_General_BIN2 NOT NULL,
    [BaseDn] NVARCHAR (255) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [ActiveDirectoryDomains_Domain] PRIMARY KEY CLUSTERED ([Domain] ASC)
);

