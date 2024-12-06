CREATE FUNCTION Calculate.GetStructuredCablingStudioParametersDiapasons(
    @IsRecommendationsAvailability BIT,
    @IsStrictComplianceWithTheStandart BIT,
    @IsAnArbitraryNumberOfPorts BIT,
    @IsTechnologicalReserveAvailability BIT
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
    SELECT @NumberOfWorkplacesDiapason = Calculate.GetNumberOfWorkplacesDiapason(@IsStrictComplianceWithTheStandart);
    SELECT @CableHankMeterageDiapason = Calculate.GetCableHankMeterageDiapason(@IsStrictComplianceWithTheStandart);
    SELECT @TechnologicalReserveDiapason = Calculate.GetTechnologicalReserveDiapason(@IsTechnologicalReserveAvailability);


END;