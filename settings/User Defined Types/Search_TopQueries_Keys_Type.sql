CREATE TYPE [settings].[Search_TopQueries_Keys_Type] AS TABLE (
    [ClusterName]    NVARCHAR (450)  COLLATE Latin1_General_BIN2 NOT NULL,
    [SqlServerName]  NVARCHAR (450)  COLLATE Latin1_General_BIN2 NOT NULL,
    [DatabaseName]   NVARCHAR (450)  COLLATE Latin1_General_BIN2 NOT NULL,
    [SqlHandle]      VARBINARY (900) NOT NULL,
    [StatementEnd]   BIGINT          NOT NULL,
    [StatementStart] BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL);

