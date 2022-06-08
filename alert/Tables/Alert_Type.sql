CREATE TABLE [alert].[Alert_Type] (
    [AlertType]   INT            NOT NULL,
    [Event]       TINYINT        NOT NULL,
    [Name]        NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS CONSTRAINT [DF_Alert_Type_Name] DEFAULT ('') NOT NULL,
    [Description] NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS CONSTRAINT [DF_Alert_Type_Description] DEFAULT ('') NOT NULL,
    [ShortName]   NVARCHAR (28)  COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Priority]    SMALLINT       CONSTRAINT [DF_Alert_Type_Priority] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [Alert_Type_AlertType] PRIMARY KEY CLUSTERED ([AlertType] ASC)
);

