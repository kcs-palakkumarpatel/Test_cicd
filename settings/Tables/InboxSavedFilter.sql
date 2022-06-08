CREATE TABLE [settings].[InboxSavedFilter] (
    [Id]                       BIGINT         NOT NULL,
    [Name]                     NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [AlertTypeRestricted]      BIT            NOT NULL,
    [StartDate]                DATETIME       NULL,
    [EndDate]                  DATETIME       NULL,
    [LastTimeSpan]             BIGINT         NULL,
    [IncludeCleared]           BIT            NOT NULL,
    [IncludeNonCleared]        BIT            NOT NULL,
    [IncludeRead]              BIT            NOT NULL,
    [IncludeUnRead]            BIT            NOT NULL,
    [IncludeEvent]             BIT            NOT NULL,
    [IncludeActiveContinous]   BIT            NOT NULL,
    [IncludeFinishedContinous] BIT            NOT NULL,
    [IncludeWithComments]      BIT            NOT NULL,
    [IncludeWithoutComments]   BIT            NOT NULL,
    [IncludeMonitoring]        BIT            NOT NULL,
    [IncludeNonMonitoring]     BIT            NOT NULL,
    [ExcludedSeverities]       BIGINT         NOT NULL,
    CONSTRAINT [InboxSavedFilter_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SavedFilter_Names]
    ON [settings].[InboxSavedFilter]([Name] ASC);

