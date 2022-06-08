CREATE TABLE [settings].[LicenceActivations] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [SerialNumber]       NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [ActivationResponse] NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [LicenceActivations_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [LicenceActivations_SerialNumber] UNIQUE NONCLUSTERED ([SerialNumber] ASC)
);

