
CREATE VIEW [alert].[Alert_Summary]
AS
SELECT        TargetObject, [Read],
                             (SELECT        TOP (1) Date
                               FROM            alert.Alert_Severity AS s
                               WHERE        (alert.Alert.AlertId = AlertId)
                               ORDER BY Date DESC) AS LastUpdate,
                             (SELECT        MAX(Severity) AS Expr1
                               FROM            alert.Alert_Severity AS s
                               WHERE        (alert.Alert.AlertId = AlertId)) AS WorstSeverity, Cleared
FROM            alert.Alert