﻿CREATE TABLE [data].[Cluster_SqlServer_Agent_Job_History_Instances] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Message]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_RunDuration]   BIGINT         NULL,
    [_RunStatus]     BIGINT         NULL,
    [_SqlMessageId]  BIGINT         NULL,
    [_SqlSeverity]   BIGINT         NULL,
    [_StepID]        BIGINT         NULL,
    [_StepMessage]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_StepName]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_SqlServer_Agent_Job_History_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Agent_Job_History_Instances_Cluster_SqlServer_Agent_Job_History_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Agent_Job_History_Keys] ([Id]) ON DELETE CASCADE
);

