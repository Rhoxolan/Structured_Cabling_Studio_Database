CREATE FUNCTION Calculate.GetMaxPermanentLinkDiapason(@IsStrictComplianceWithTheStandart)
RETURNS XML
AS
BEGIN
    DECLARE @MaxPermanentLinkDiapason XML;

    DECLARE @Min DECIMAL(10, 5);
    DECLARE @Max DECIMAL(10, 5);

    SELECT @Min = Min, @Max = Max
    FROM Calculate.MaxPermanentLinkDiapasons
    WHERE IsStrictComplianceWithTheStandart = @IsStrictComplianceWithTheStandart;

    SET @MaxPermanentLinkDiapason = (
        SELECT
            @Min AS 'Min',
            @Max AS 'Max'
        FOR XML PATH('MaxPermanentLinkDiapason'), TYPE
    );

    RETURN @MaxPermanentLinkDiapason;
END;