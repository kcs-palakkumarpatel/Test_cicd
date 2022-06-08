﻿CREATE FUNCTION [data].[Cluster_Machine_Security_CommunicationProtocol_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[Id]
FROM
    [data].[Cluster_Machine_Security_CommunicationProtocol_Keys]
WHERE
    [CollectionDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[Cluster_Machine_Security_CommunicationProtocol_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)