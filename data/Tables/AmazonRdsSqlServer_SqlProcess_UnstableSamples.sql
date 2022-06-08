﻿CREATE TABLE [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples] (
    [Id]                               BIGINT          NOT NULL,
    [CollectionDate]                   BIGINT          NOT NULL,
    [_BlockingSessionId]               BIGINT          NULL,
    [_BlockingSessionLoginTime]        BIGINT          NULL,
    [_Command]                         NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_CumulativeLogicalReads]          BIGINT          NULL,
    [_CumulativeProcessorTime]         BIGINT          NULL,
    [_CumulativeReads]                 BIGINT          NULL,
    [_CumulativeWrites]                BIGINT          NULL,
    [_DatabaseName]                    NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_ExecutingProcedure]              NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_FullCommand]                     NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_InternalObjectsAllocBytes]       BIGINT          NULL,
    [_InternalObjectsDeallocBytes]     BIGINT          NULL,
    [_LastRequestEnd]                  BIGINT          NULL,
    [_LastRequestStart]                BIGINT          NULL,
    [_LastWaitType]                    NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_MemoryUsage]                     BIGINT          NULL,
    [_MostRecentSqlHandle]             VARBINARY (MAX) NULL,
    [_OpenTransactions]                BIGINT          NULL,
    [_PlanHandle]                      VARBINARY (MAX) NULL,
    [_QueryHash]                       VARBINARY (MAX) NULL,
    [_QueryPlanHash]                   VARBINARY (MAX) NULL,
    [_QueryStartTime]                  BIGINT          NULL,
    [_QueryStartTimeIsCalculated]      BIT             NULL,
    [_SqlHandle]                       VARBINARY (MAX) NULL,
    [_StatementEnd]                    BIGINT          NULL,
    [_StatementStart]                  BIGINT          NULL,
    [_Status]                          NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_TotalBlockingTime]               BIGINT          NULL,
    [_UserObjectsAllocBytes]           BIGINT          NULL,
    [_UserObjectsDeallocBytes]         BIGINT          NULL,
    [_UserObjectsDeferredDeallocBytes] BIGINT          NULL,
    [_WaitResource]                    NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    [_WaitTime]                        BIGINT          NULL,
    [_WaitType]                        NVARCHAR (MAX)  COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_SqlProcess_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_SqlProcess_UnstableSamples_AmazonRdsSqlServer_SqlProcess_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_SqlProcess_Keys] ([Id]) ON DELETE CASCADE
);

