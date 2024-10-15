CREATE PROCEDURE CalculateStructuredCablingConfiguration
    @ConfigurationCalculateParameters XML INPUT
    @StructuredCablingStudioParameters XML INPUT
    @CablingConfiguration XML OUTPUT
AS
BEGIN
    DECLARE @CableHankMeterage INT;
    DECLARE @IsCableHankMeterageAvailability BIT;

    DECLARE @TechnologicalReserve FLOAT;
    DECLARE @IsRecommendationsAvailability BIT;
    DECLARE @IsStrictComplianceWithTheStandart BIT;
    DECLARE @IsAnArbitraryNumberOfPorts BIT;
    DECLARE @IsTechnologicalReserveAvailability BIT;