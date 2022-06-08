CREATE TABLE [settings].[EmailSettings] (
    [Id]                      INT            NOT NULL,
    [Server]                  NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Port]                    INT            NOT NULL,
    [UseAuthentication]       BIT            NOT NULL,
    [IgnoreSslErrors]         BIT            CONSTRAINT [IgnoreSslErrors_Default] DEFAULT ((0)) NOT NULL,
    [UserName]                NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Password]                NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [ConnectionSecurityMode]  INT            NOT NULL,
    [EmailFrom]               NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [GlobalAlertEmailEnable]  BIT            NOT NULL,
    [AlertEmailOnEnded]       BIT            NOT NULL,
    [WebUiPrefix]             NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [AlertEmailLimit]         INT            CONSTRAINT [AlertEmailLimit_Default] DEFAULT ((30)) NOT NULL,
    [NotificationLevel]       INT            CONSTRAINT [NotificationLevel_Default] DEFAULT ((0)) NOT NULL,
    [Encrypted]               BIT            CONSTRAINT [Encrypted_Default] DEFAULT ((0)) NOT NULL,
    [EmailOnBaseMonitorError] BIT            CONSTRAINT [EmailOnBaseMonitorError_Default] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [EmailSettings_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [AlertEmailLimit_GreaterThanZero] CHECK ([AlertEmailLimit]>(0))
);

