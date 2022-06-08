CREATE TABLE [data].[Cluster_SqlServer_Properties_Registry_StableSamples] (
    [Id]                                       BIGINT         NOT NULL,
    [CollectionDate]                           BIGINT         NOT NULL,
    [_AuditLevel]                              BIGINT         NULL,
    [_CertificateThumbprint]                   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_CustomerExperienceAuditDirectory]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_CustomerExperienceErrorReportingEnabled] BIT            NULL,
    [_CustomerExperienceFeedbackEnabled]       BIT            NULL,
    [_ForceEncryption]                         BIT            NULL,
    [_HideInstance]                            BIT            NULL,
    [_InstallationDirectory]                   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_MaxNumberErrorLogFiles]                  BIGINT         NULL,
    CONSTRAINT [Cluster_SqlServer_Properties_Registry_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Properties_Registry_StableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

