CREATE FUNCTION [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Sightings_Removable]
(
    @AzureSqlServer_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_StoredProcedure_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent AS NVARCHAR(450)
    , @AzureSqlServer_Database_StoredProcedure_ParentSP_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Sightings].[SightingDate], [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Sightings].[Id]
FROM [data].[AzureSqlServer_Keys]
INNER JOIN [data].[AzureSqlServer_Database_Keys] ON [data].[AzureSqlServer_Database_Keys].[ParentId] = [data].[AzureSqlServer_Keys].[Id]
INNER JOIN [data].[AzureSqlServer_Database_StoredProcedure_Keys] ON [data].[AzureSqlServer_Database_StoredProcedure_Keys].[ParentId] = [data].[AzureSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys] ON [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId] = [data].[AzureSqlServer_Database_StoredProcedure_Keys].[Id]
INNER JOIN [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Sightings] ON [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Sightings].[Id] = [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[Id]
 WHERE  (@AzureSqlServer_Name IS NULL OR [data].[AzureSqlServer_Keys].[_Name] = @AzureSqlServer_Name)
 AND  (@AzureSqlServer_Database_Name IS NULL OR [data].[AzureSqlServer_Database_Keys].[_Name] = @AzureSqlServer_Database_Name)
 AND  (@AzureSqlServer_Database_StoredProcedure_Name IS NULL OR [data].[AzureSqlServer_Database_StoredProcedure_Keys].[_Name] = @AzureSqlServer_Database_StoredProcedure_Name)
 AND  (@AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent IS NULL OR [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[_DatabaseNameParent] = @AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent)
 AND  (@AzureSqlServer_Database_StoredProcedure_ParentSP_Name IS NULL OR [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[_Name] = @AzureSqlServer_Database_StoredProcedure_ParentSP_Name)