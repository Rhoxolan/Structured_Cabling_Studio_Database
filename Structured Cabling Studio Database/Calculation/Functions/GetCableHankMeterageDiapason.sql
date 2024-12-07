CREATE FUNCTION Calculate.GetCableHankMeterageDiapason()
RETURNS XML
AS
BEGIN
    DECLARE @CableHankMeterageDiapason XML;

    DECLARE @Min DECIMAL(10, 5);
    DECLARE @Max DECIMAL(10, 5);

    SELECT @Min = Min, @Max = Max
    FROM Calculate.CableHankMeterageDiapasons;

    SET @CableHankMeterage = (
        SELECT
            @Min AS 'Min',
            @Max AS 'Max'
        FOR XML PATH('CableHankMeterageDiapason'), TYPE
    );

    RETURN @CableHankMeterageDiapason;
END;