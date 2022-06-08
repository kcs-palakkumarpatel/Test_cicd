CREATE TABLE [settings].[VMwareHosts] (
    [Id]                    UNIQUEIDENTIFIER NOT NULL,
    [CreatedDate]           BIGINT           NOT NULL,
    [ModifiedDate]          BIGINT           NOT NULL,
    [IsValid]               BIT              NOT NULL,
    [IsSuspended]           BIT              NOT NULL,
    [User]                  NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Password]              NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Name]                  NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [RequestedLicenceLevel] INT              NOT NULL,
    [EffectiveLicenceLevel] INT              NOT NULL,
    [AuthenticationMode]    INT              CONSTRAINT [VMwareHosts_df_AuthenticationMode] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [VMwareHosts_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [VMwareHosts_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

