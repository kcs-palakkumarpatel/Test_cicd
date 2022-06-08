CREATE TABLE [settings].[ObjectsPendingRemoval] (
    [TargetObject] NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [ObjectsPendingRemoval_TargetObject] PRIMARY KEY CLUSTERED ([TargetObject] ASC) WITH (IGNORE_DUP_KEY = ON)
);

