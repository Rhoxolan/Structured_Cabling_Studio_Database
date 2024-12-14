CREATE FUNCTION Calculation.GetTechnologicalReserveDiapason()
RETURNS XML
AS
BEGIN
    DECLARE @TechnologicalReserveDiapason XML;

    DECLARE @Min DECIMAL(10, 5);
    DECLARE @Max DECIMAL(10, 5);

    SELECT @Min = Min, @Max = Max
    FROM Calculation.TechnologicalReserveDiapasons;

    SET @TechnologicalReserveDiapason = (
        SELECT
            @Min AS 'Min',
            @Max AS 'Max'
        FOR XML PATH('TechnologicalReserveDiapason'), TYPE
    );

    RETURN @TechnologicalReserveDiapason;
END;