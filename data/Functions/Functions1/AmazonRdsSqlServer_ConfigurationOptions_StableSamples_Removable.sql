﻿CREATE FUNCTION [data].[AmazonRdsSqlServer_ConfigurationOptions_StableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_ConfigurationOptions_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_ConfigurationOptions_StableSamples].[Id], [data].[AmazonRdsSqlServer_ConfigurationOptions_StableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_ConfigurationOptions_Keys] ON [data].[AmazonRdsSqlServer_ConfigurationOptions_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_ConfigurationOptions_StableSamples] ON [data].[AmazonRdsSqlServer_ConfigurationOptions_StableSamples].[Id] = [data].[AmazonRdsSqlServer_ConfigurationOptions_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_ConfigurationOptions_Name IS NULL OR [data].[AmazonRdsSqlServer_ConfigurationOptions_Keys].[_Name] = @AmazonRdsSqlServer_ConfigurationOptions_Name)