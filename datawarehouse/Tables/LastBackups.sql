CREATE TABLE [datawarehouse].[LastBackups] (
    [ClusterName]    NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [InstanceName]   NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [DatabaseName]   NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [StartDate]      BIGINT         NULL,
    [FinishDate]     BIGINT         NOT NULL,
    [Size]           BIGINT         NULL,
    [BackupType]     NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [IsNativeBackup] BIT            NULL,
    [BackupDevice]   NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    CONSTRAINT [PK_datawarehouse_LastBackups] PRIMARY KEY CLUSTERED ([ClusterName] ASC, [InstanceName] ASC, [DatabaseName] ASC, [BackupType] ASC)
);

