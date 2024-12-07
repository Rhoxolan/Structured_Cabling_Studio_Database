CREATE FUNCTION Calculate.GetNumberOfPortsDiapason(@IsAnArbitraryNumberOfPorts)
RETURNS XML
AS
BEGIN
    DECLARE @NumberOfPortsDiapason XML;

    DECLARE @Min DECIMAL(10, 5);
    DECLARE @Max DECIMAL(10, 5);

    SELECT @Min = Min, @Max = Max
    FROM Calculate.NumberOfPortsDiapasons
    WHERE IsAnArbitraryNumberOfPorts = @IsAnArbitraryNumberOfPorts;

    SET @NumberOfPortsDiapason = (
        SELECT
            @Min AS 'Min',
            @Max AS 'Max'
        FOR XML PATH('NumberOfPortsDiapason'), TYPE
    );

    RETURN @NumberOfPortsDiapason;
END;