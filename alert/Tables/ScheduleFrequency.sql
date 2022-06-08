CREATE TABLE [alert].[ScheduleFrequency] (
    [Id]   INT            NOT NULL,
    [Name] NVARCHAR (128) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [PK_ScheduleFrequency__Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_ScheduleFrequency__Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

