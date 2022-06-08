CREATE TABLE [settings].[TagAssociations] (
    [Id]              BIGINT         IDENTITY (1, 1) NOT NULL,
    [EntityReference] NVARCHAR (450) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Tag]             NVARCHAR (400) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [TagAssociations_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [Unique_Entity_Tag] UNIQUE NONCLUSTERED ([EntityReference] ASC, [Tag] ASC)
);


GO
CREATE NONCLUSTERED INDEX [EntityReference_Index]
    ON [settings].[TagAssociations]([EntityReference] ASC);


GO
CREATE NONCLUSTERED INDEX [Tag_Index]
    ON [settings].[TagAssociations]([Tag] ASC);

