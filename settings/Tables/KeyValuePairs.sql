CREATE TABLE [settings].[KeyValuePairs] (
    [KeyName]      NVARCHAR (54)  COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [KeyValue]     NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [KeyValueType] NVARCHAR (50)  COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [PK_KeyValuePairs] PRIMARY KEY CLUSTERED ([KeyName] ASC),
    CONSTRAINT [CK_KeyValuePairValueIsValid] CHECK ([settings].[CheckKeyValuePairSetting]([KeyValue],[KeyValueType])=(1))
);

