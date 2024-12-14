CREATE FUNCTION Calculation.GetStructuredCablingStudioParametersDiapasons(
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

    SELECT @MinPermanentLinkDiapason = Calculation.GetMinPermanentLinkDiapason(@IsStrictComplianceWithTheStandart);
    SELECT @MaxPermanentLinkDiapason = Calculation.GetMaxPermanentLinkDiapason(@IsStrictComplianceWithTheStandart);
    SELECT @NumberOfPortsDiapason = Calculation.GetNumberOfPortsDiapason(@IsAnArbitraryNumberOfPorts);
    SELECT @NumberOfWorkplacesDiapason = Calculation.GetNumberOfWorkplacesDiapason();
    SELECT @CableHankMeterageDiapason = Calculation.GetCableHankMeterageDiapason();
    SELECT @TechnologicalReserveDiapason = Calculation.GetTechnologicalReserveDiapason();

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