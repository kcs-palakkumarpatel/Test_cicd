CREATE FUNCTION [alert].[CheckSuppressionTargetExists]
(
    @id AS UNIQUEIDENTIFIER
)
RETURNS BIT
AS
BEGIN
    RETURN CAST(
           (
               SELECT COUNT(*) FROM alert.SuppressionTargets WHERE @id = Id
           ) AS BIT);
END;