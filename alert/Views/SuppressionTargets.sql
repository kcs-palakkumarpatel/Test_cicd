CREATE VIEW [alert].[SuppressionTargets] AS
SELECT Id FROM settings.Clusters
UNION
SELECT Id FROM settings.SqlServers
UNION
SELECT Id FROM settings.Machines
UNION
SELECT Id FROM settings.AzureManagedInstances
UNION
SELECT Id FROM settings.AzureSqlServers
UNION
SELECT Id FROM settings.AzureSqlDatabases
UNION
SELECT Id FROM settings.AmazonRdsSqlServers
UNION
SELECT GroupId AS Id FROM settings.[Group]