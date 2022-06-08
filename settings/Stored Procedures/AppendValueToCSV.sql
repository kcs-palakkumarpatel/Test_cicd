CREATE PROCEDURE [settings].[AppendValueToCSV]
    @KeyName NCHAR(50)
  , @NewValue NVARCHAR(MAX)
AS
BEGIN
    IF CHARINDEX ('"', @NewValue) < 1
    BEGIN
        SET @NewValue = QUOTENAME (@NewValue, '"');
    END;

    IF NOT EXISTS (SELECT   * FROM  settings.KeyValuePairs WHERE KeyName = @KeyName)
    BEGIN
		EXEC settings.SetKeyValuePair @KeyName = @KeyName
		                            , @KeyValue = @NewValue
		                            , @KeyValueType = N'CSV';
    END;
    ELSE
    BEGIN
		DECLARE @OldValue NVARCHAR(MAX);

		SELECT @OldValue = KeyValue
		FROM settings.KeyValuePairs
		WHERE KeyName = @KeyName;

		DECLARE @HistoryKey NCHAR(54);
		SET @HistoryKey = RTRIM(CAST(@KeyName AS NVARCHAR(50))) + '-Old';

		EXEC settings.SetKeyValuePair @KeyName = @HistoryKey
		                            , @KeyValue = @OldValue
		                            , @KeyValueType = N'CSV'

		SET @NewValue = @OldValue + ',' + @NewValue;

	    EXEC settings.SetKeyValuePair @KeyName = @KeyName
		                            , @KeyValue = @NewValue
		                            , @KeyValueType = N'CSV';
    END;
END;