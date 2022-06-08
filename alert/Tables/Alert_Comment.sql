CREATE TABLE [alert].[Alert_Comment] (
    [CommentId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [AlertId]     BIGINT         NOT NULL,
    [Author]      NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Date]        BIGINT         NOT NULL,
    [CommentText] NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [Alert_Comment_CommentId] PRIMARY KEY CLUSTERED ([CommentId] ASC),
    CONSTRAINT [Alert_Comment_Alert] FOREIGN KEY ([AlertId]) REFERENCES [alert].[Alert] ([AlertId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [Alert_Comment_Date]
    ON [alert].[Alert_Comment]([Date] ASC);

