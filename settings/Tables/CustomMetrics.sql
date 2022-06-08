CREATE TABLE [settings].[CustomMetrics] (
    [Id]                    BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]                  NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Description]           NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Tsql]                  NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Frequency]             BIGINT         NOT NULL,
    [UseRateOfChange]       BIT            NOT NULL,
    [Multiplier]            FLOAT (53)     NOT NULL,
    [Status]                TINYINT        NOT NULL,
    [Databases]             XML            NOT NULL,
    [DatabaseSelectionMode] TINYINT        NOT NULL,
    CONSTRAINT [CustomMetrics_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

