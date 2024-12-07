CREATE PROCEDURE Calculation.SetStructuredCablingStudioParametersDiapasons
    @StructuredCablingStudioParameters XML
AS
BEGIN
    DECLARE @IsStrictComplianceWithTheStandart BIT;
    DECLARE @IsAnArbitraryNumberOfPorts BIT;

    DECLARE @StructuredCablingStudioDiapasons XML;

    SET @IsStrictComplianceWithTheStandart = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsStrictComplianceWithTheStandart)[1]', 'bit');
    SET @IsAnArbitraryNumberOfPorts = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsAnArbitraryNumberOfPorts)[1]', 'bit');

    SET @StructuredCablingStudioDiapasons = Calculate.GetStructuredCablingStudioParametersDiapasons(@IsStrictComplianceWithTheStandart,
                                                                                                @IsAnArbitraryNumberOfPorts);

END;