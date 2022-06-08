﻿CREATE FUNCTION [data].[AmazonRdsSqlServer_Services_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Services_ServiceName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Services_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_Services_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Services_Keys] ON [data].[AmazonRdsSqlServer_Services_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Services_Sightings] ON [data].[AmazonRdsSqlServer_Services_Sightings].[Id] = [data].[AmazonRdsSqlServer_Services_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Services_ServiceName IS NULL OR [data].[AmazonRdsSqlServer_Services_Keys].[_ServiceName] = @AmazonRdsSqlServer_Services_ServiceName)