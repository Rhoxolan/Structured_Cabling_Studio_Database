CREATE FUNCTION Calculate.GetMinPermanentLinkDiapason(@IsStrictComplianceWithTheStandart)
RETURNS XML
AS
BEGIN
    DECLARE @MinPermanentLinkDiapason XML;

    DECLARE @Min DECIMAL(10, 5);
    DECLARE @Max DECIMAL(10, 5);

    SELECT @Min = Min, @Max = Max
    FROM Calculate.MinPermanentLinkDiapasons
    WHERE IsStrictComplianceWithTheStandart = @IsStrictComplianceWithTheStandart;

    SET @MinPermanentLinkDiapason = (
        SELECT
            @Min AS 'Min',
            @Max AS 'Max'
        FOR XML PATH('MinPermanentLinkDiapason'), TYPE
    );

    RETURN @MinPermanentLinkDiapason;
END;