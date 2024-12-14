CREATE FUNCTION Calculation.GetMinPermanentLinkDiapason(@IsStrictComplianceWithTheStandart BIT)
RETURNS XML
AS
BEGIN
    DECLARE @MinPermanentLinkDiapason XML;

    DECLARE @Min DECIMAL(10, 5);
    DECLARE @Max DECIMAL(10, 5);

    SELECT @Min = Min, @Max = Max
    FROM Calculation.MinPermanentLinkDiapasons
    WHERE IsStrictComplianceWithTheStandart = @IsStrictComplianceWithTheStandart;

    SET @MinPermanentLinkDiapason = (
        SELECT
            @Min AS 'Min',
            @Max AS 'Max'
        FOR XML PATH('MinPermanentLinkDiapason'), TYPE
    );

    RETURN @MinPermanentLinkDiapason;
END;