CREATE TABLE [settings].[Clusters] (
    [Id]                       UNIQUEIDENTIFIER NOT NULL,
    [CreatedDate]              BIGINT           NOT NULL,
    [ModifiedDate]             BIGINT           NOT NULL,
    [IsValid]                  BIT              NOT NULL,
    [IsSuspended]              BIT              NOT NULL,
    [CredentialsDiscriminator] INT              NOT NULL,
    [User]                     NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Domain]                   NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Password]                 NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Name]                     NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [IsCluster]                BIT              NOT NULL,
    [IsAddressDetected]        BIT              NOT NULL,
    [HasDetectionFailed]       BIT              CONSTRAINT [Clusters_df_HasDetectionFailed] DEFAULT ((0)) NOT NULL,
    [NodeCount]                INT              NOT NULL,
    [RequestedLicenceLevel]    INT              NOT NULL,
    [EffectiveLicenceLevel]    INT              NOT NULL,
    [AutoDetectClusterName]    BIT              CONSTRAINT [Clusters_df_AutoDetectClusterName] DEFAULT ((1)) NOT NULL,
    [WmiConnectionMethod]      NVARCHAR (255)   COLLATE Latin1_General_CS_AS_KS_WS CONSTRAINT [Clusters_df_WmiConnectionMethod] DEFAULT (N'DCOM') NOT NULL,
    CONSTRAINT [Clusters_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [Clusters_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

