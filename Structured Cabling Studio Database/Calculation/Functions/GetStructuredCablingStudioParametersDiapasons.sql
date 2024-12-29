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

    SELECT @MinPermanentLinkDiapason = Calculation.GetMinPermanentLinkDiapason(@IsStrictComplianceWithTheStandart),
        @MaxPermanentLinkDiapason = Calculation.GetMaxPermanentLinkDiapason(@IsStrictComplianceWithTheStandart),
        @NumberOfPortsDiapason = Calculation.GetNumberOfPortsDiapason(@IsAnArbitraryNumberOfPorts),
        @NumberOfWorkplacesDiapason = Calculation.GetNumberOfWorkplacesDiapason(),
        @CableHankMeterageDiapason = Calculation.GetCableHankMeterageDiapason(),
        @TechnologicalReserveDiapason = Calculation.GetTechnologicalReserveDiapason();

    SET @StructuredCablingStudioDiapasons = (
        SELECT
            @MinPermanentLinkDiapason AS '*',
            @MaxPermanentLinkDiapason AS '*',
            @NumberOfPortsDiapason AS '*',
            @NumberOfWorkplacesDiapason AS '*',
            @CableHankMeterageDiapason AS '*',
            @TechnologicalReserveDiapason AS '*'
        FOR XML PATH('StructuredCablingStudioDiapasons'), TYPE
    );

    RETURN @StructuredCablingStudioDiapasons;
END;