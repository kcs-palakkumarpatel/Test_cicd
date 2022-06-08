CREATE TYPE [data].[Cluster_SqlServer_Properties_Registry_StableSamples_Type] AS TABLE (
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
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

