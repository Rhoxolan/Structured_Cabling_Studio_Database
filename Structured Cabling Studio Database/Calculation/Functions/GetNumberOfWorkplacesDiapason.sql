CREATE FUNCTION Calculation.GetNumberOfWorkplacesDiapason()
RETURNS XML
AS
BEGIN
    DECLARE @NumberOfWorkplacesDiapason XML;

    DECLARE @Min DECIMAL(10, 5);
    DECLARE @Max DECIMAL(10, 5);

    SELECT @Min = Min, @Max = Max
    FROM Calculation.NumberOfWorkplacesDiapasons;

    SET @NumberOfWorkplacesDiapason = (
        SELECT
            @Min AS 'Min',
            @Max AS 'Max'
        FOR XML PATH('NumberOfWorkplacesDiapason'), TYPE
    );

    RETURN @NumberOfWorkplacesDiapason;
END;