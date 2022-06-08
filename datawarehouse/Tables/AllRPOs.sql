CREATE TABLE [datawarehouse].[AllRPOs] (
    [ClusterName]      NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [InstanceName]     NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [DatabaseName]     NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [BackupFinishDate] BIGINT         NOT NULL,
    [DurationTicks]    BIGINT         NULL,
    CONSTRAINT [PK_datawarehouse_AllRPOs] PRIMARY KEY CLUSTERED ([ClusterName] ASC, [InstanceName] ASC, [DatabaseName] ASC, [BackupFinishDate] ASC)
);

