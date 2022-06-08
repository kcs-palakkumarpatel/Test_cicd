CREATE TABLE [data].[AmazonRdsSqlServer_Agent_Job_Instances] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_DateCreated]   BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_Instances_AmazonRdsSqlServer_Agent_Job_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Agent_Job_Keys] ([Id]) ON DELETE CASCADE
);

