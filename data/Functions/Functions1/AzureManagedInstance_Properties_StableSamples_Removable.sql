﻿CREATE FUNCTION [data].[AzureManagedInstance_Properties_StableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Properties_StableSamples].[Id], [data].[AzureManagedInstance_Properties_StableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Properties_StableSamples] ON [data].[AzureManagedInstance_Properties_StableSamples].[Id] = [data].[AzureManagedInstance_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)