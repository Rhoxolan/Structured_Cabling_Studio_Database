CREATE PROCEDURE Calculation.SetStructuredCablingStudioParametersDiapasons
    @StructuredCablingStudioParameters XML
AS
BEGIN
    DECLARE @IsRecommendationsAvailability BIT;
    DECLARE @IsStrictComplianceWithTheStandart BIT;
    DECLARE @IsAnArbitraryNumberOfPorts BIT;
    DECLARE @IsTechnologicalReserveAvailability BIT;

    DECLARE @StructuredCablingStudioDiapasons XML;

    SET @IsRecommendationsAvailability = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsRecommendationsAvailability)[1]', 'bit');
    SET @IsStrictComplianceWithTheStandart = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsStrictComplianceWithTheStandart)[1]', 'bit');
    SET @IsAnArbitraryNumberOfPorts = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsAnArbitraryNumberOfPorts)[1]', 'bit');
    SET @IsTechnologicalReserveAvailability = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsTechnologicalReserveAvailability)[1]', 'bit');

    SET @StructuredCablingStudioDiapasons = Calculate.GetStructuredCablingStudioParametersDiapasons(@IsRecommendationsAvailability,
                                                                                                @IsStrictComplianceWithTheStandart,
                                                                                                @IsAnArbitraryNumberOfPorts,
                                                                                                @IsTechnologicalReserveAvailability);

END;