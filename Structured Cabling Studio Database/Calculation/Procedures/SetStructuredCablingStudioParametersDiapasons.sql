CREATE PROCEDURE Calculation.SetStructuredCablingStudioParametersDiapasons
    @StructuredCablingStudioParameters XML,
    @StructuredCablingStudioDiapasons XML OUTPUT
AS
BEGIN
    DECLARE @IsStrictComplianceWithTheStandart BIT;
    DECLARE @IsAnArbitraryNumberOfPorts BIT;

    SET @IsStrictComplianceWithTheStandart = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsStrictComplianceWithTheStandart)[1]', 'bit');
    SET @IsAnArbitraryNumberOfPorts = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsAnArbitraryNumberOfPorts)[1]', 'bit');

    SET @StructuredCablingStudioDiapasons = Calculation.GetStructuredCablingStudioParametersDiapasons(@IsStrictComplianceWithTheStandart,
                                                                                                @IsAnArbitraryNumberOfPorts);

END;