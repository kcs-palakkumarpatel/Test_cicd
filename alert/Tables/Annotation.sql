CREATE TABLE [alert].[Annotation] (
    [AnnotationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [Date]         BIGINT         NOT NULL,
    [InstanceName] NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [DatabaseName] NVARCHAR (128) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Description]  NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Url]          NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Source]       NVARCHAR (50)  COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [SpecificInfo] NVARCHAR (50)  COLLATE Latin1_General_CS_AS_KS_WS NULL,
    CONSTRAINT [PK_alert.Annotation] PRIMARY KEY CLUSTERED ([AnnotationId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Annotation_InstanceName_Date]
    ON [alert].[Annotation]([InstanceName] ASC, [Date] ASC);

