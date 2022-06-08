CREATE TABLE [settings].[PurgeSettings] (
    [Id]                             INT NOT NULL,
    [GlobalEnable]                   BIT NOT NULL,
    [MachineBasicData]               INT NOT NULL,
    [MachineProcessData]             INT NOT NULL,
    [SqlBasicData]                   INT NOT NULL,
    [SqlDatabaseUnstableSamplesData] INT NOT NULL,
    [SqlProcessData]                 INT NOT NULL,
    [SqlTopQueriesData]              INT NOT NULL,
    [SqlQueryPlansData]              INT NOT NULL,
    [SqlTraceData]                   INT NOT NULL,
    [StorageData]                    INT NOT NULL,
    [BackupData]                     INT NOT NULL,
    [SqlAgentJobData]                INT NOT NULL,
    [CustomMetricsData]              INT NOT NULL,
    [PermissionsData]                INT NOT NULL,
    [ServerWaitsData]                INT NOT NULL,
    [Alert]                          INT NOT NULL,
    CONSTRAINT [PurgeSettings_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

