﻿CREATE FUNCTION [data].[AzureManagedInstance_AccessMethods_UnstableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_AccessMethods_UnstableSamples].[Id], [data].[AzureManagedInstance_AccessMethods_UnstableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_AccessMethods_UnstableSamples] ON [data].[AzureManagedInstance_AccessMethods_UnstableSamples].[Id] = [data].[AzureManagedInstance_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)