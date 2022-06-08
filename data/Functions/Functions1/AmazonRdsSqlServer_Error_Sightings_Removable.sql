CREATE FUNCTION [data].[AmazonRdsSqlServer_Error_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Error_LogDate AS BIGINT
    , @AmazonRdsSqlServer_Error_SequenceNumber AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Error_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_Error_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Error_Keys] ON [data].[AmazonRdsSqlServer_Error_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Error_Sightings] ON [data].[AmazonRdsSqlServer_Error_Sightings].[Id] = [data].[AmazonRdsSqlServer_Error_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Error_LogDate IS NULL OR [data].[AmazonRdsSqlServer_Error_Keys].[_LogDate] = @AmazonRdsSqlServer_Error_LogDate)
 AND  (@AmazonRdsSqlServer_Error_SequenceNumber IS NULL OR [data].[AmazonRdsSqlServer_Error_Keys].[_SequenceNumber] = @AmazonRdsSqlServer_Error_SequenceNumber)