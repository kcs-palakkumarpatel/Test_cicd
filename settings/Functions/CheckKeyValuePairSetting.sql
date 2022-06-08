
CREATE FUNCTION [settings].[CheckKeyValuePairSetting]
(
	@keyvalue nvarchar(MAX), @keyvaluetype nvarchar(10)
)
RETURNS bit
AS
BEGIN

	DECLARE @result bit;
	SET @result = 1  

	IF @keyvaluetype != UPPER(@keyvaluetype) COLLATE LATIN1_GENERAL_CS_AS
		SET @result = 0
	ELSE IF @keyvaluetype = 'NUMERIC'
		SET @result = ISNUMERIC(@keyvalue);
	ELSE IF @keyvaluetype = 'BOOLEAN'
		SET @result = CASE WHEN @keyvalue = 'True' OR @keyvalue = 'False' THEN 1 ELSE 0 END;
	ELSE IF @keyvaluetype = 'STRING'
		set @result = 1;
	ELSE IF @keyvaluetype = 'DATE'
	    -- This check doesn't validate the full roundtrip format we use for DateTime, since SQL Server's pattern
	    -- matching isn't sufficiently sophisticated. Nonetheless, we can validate the initial yyyy-mm-ddThh:mm:ss part
	    -- of the pattern here, and we rely on the KeyValuePair repository to actually enforce the correct parsing and
	    -- formatting. This constraint is really here to somewhat guard against manual edits.
		SET @result = CASE WHEN @keyvalue LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]T[0-9][0-9]:[0-9][0-9]:[0-9][0-9]%' THEN 1 ELSE 0 END;
	ELSE IF @keyvaluetype = 'CSV'
		SELECT @result = @result & CASE WHEN LEN(SplitValue) >= 2 AND CHARINDEX('"', SplitValue) = 1 AND CHARINDEX('"', SplitValue, 2) = LEN(SplitValue) THEN 1 ELSE 0 END 
		FROM [utils].[SplitString](@keyvalue, ',')
	ELSE
		SET @result = 0
  
	RETURN (@result);
END

