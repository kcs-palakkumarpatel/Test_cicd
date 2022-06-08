CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Agent_Job_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Agent_Job_History_Id AS BIGINT
    , @AmazonRdsSqlServer_Agent_Job_History_RunDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_History_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings] ON [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Agent_Job_Name IS NULL OR [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] = @AmazonRdsSqlServer_Agent_Job_Name)
 AND  (@AmazonRdsSqlServer_Agent_Job_History_Id IS NULL OR [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_Id] = @AmazonRdsSqlServer_Agent_Job_History_Id)
 AND  (@AmazonRdsSqlServer_Agent_Job_History_RunDate IS NULL OR [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_RunDate] = @AmazonRdsSqlServer_Agent_Job_History_RunDate)