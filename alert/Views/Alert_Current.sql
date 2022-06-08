
CREATE VIEW [alert].[Alert_Current]
AS
SELECT
  a.AlertType as AlertType,
  a.SubType as SubType,
  a.AlertId,
  a.RootCir,
  a.GroupCir,
  a.TargetObject,
  a.[Read],
  a.[ReadDate],
  aat.[Event],
  a.[LastUpdate],
  a.[Raised],
  a.[LastSeverity],
  a.[WorstSeverity],
  a.[Cleared],
  a.[ClearedDate],
  a.[LastComment]
FROM alert.Alert a
  INNER JOIN alert.Alert_Type aat ON a.AlertType = aat.AlertType