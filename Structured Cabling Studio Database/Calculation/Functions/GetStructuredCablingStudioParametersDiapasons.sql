CREATE FUNCTION Calculate.GetStructuredCablingStudioParametersDiapasons(
    @IsStrictComplianceWithTheStandart BIT,
    @IsAnArbitraryNumberOfPorts BIT
)
RETURNS XML
AS
BEGIN
    DECLARE @StructuredCablingStudioDiapasons XML;

    DECLARE @MinPermanentLinkDiapason XML;
    DECLARE @MaxPermanentLinkDiapason XML;
    DECLARE @NumberOfPortsDiapason XML;
    DECLARE @NumberOfWorkplacesDiapason XML;
    DECLARE @CableHankMeterageDiapason XML;
    DECLARE @TechnologicalReserveDiapason XML;

    SELECT @MinPermanentLinkDiapason = Calculate.GetMinPermanentLinkDiapason(@IsStrictComplianceWithTheStandart);
    SELECT @MaxPermanentLinkDiapason = Calculate.GetMaxPermanentLinkDiapason(@IsStrictComplianceWithTheStandart);
    SELECT @NumberOfPortsDiapason = Calculate.GetNumberOfPortsDiapason(@IsAnArbitraryNumberOfPorts);
    SELECT @NumberOfWorkplacesDiapason = Calculate.GetNumberOfWorkplacesDiapason();
    SELECT @CableHankMeterageDiapason = Calculate.GetCableHankMeterageDiapason();
    SELECT @TechnologicalReserveDiapason = Calculate.GetTechnologicalReserveDiapason();

    SET @StructuredCablingStudioDiapasons = (
        SELECT
            @MinPermanentLinkDiapason AS 'MinPermanentLinkDiapason',
            @MaxPermanentLinkDiapason AS 'MaxPermanentLinkDiapason',
            @NumberOfPortsDiapason AS 'NumberOfPortsDiapason',
            @NumberOfWorkplacesDiapason AS 'NumberOfWorkplacesDiapason',
            @CableHankMeterageDiapason AS 'CableHankMeterageDiapason',
            @TechnologicalReserveDiapason AS 'TechnologicalReserveDiapason'
        FOR XML PATH('StructuredCablingStudioDiapasons'), TYPE
    );

    RETURN @StructuredCablingStudioDiapasons;
END;