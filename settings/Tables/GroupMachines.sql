CREATE TABLE [settings].[GroupMachines] (
    [GroupId]   UNIQUEIDENTIFIER NOT NULL,
    [ClusterId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [GroupMachines_GroupId_ClusterId] PRIMARY KEY CLUSTERED ([GroupId] ASC, [ClusterId] ASC),
    CONSTRAINT [GroupMachines_Clusters] FOREIGN KEY ([ClusterId]) REFERENCES [settings].[Clusters] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupMachines_Group] FOREIGN KEY ([GroupId]) REFERENCES [settings].[Group] ([GroupId]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [GroupMachines_ClusterId] UNIQUE NONCLUSTERED ([ClusterId] ASC)
);

