CREATE PROCEDURE Calculation.SetStructuredCablingStudioParametersDiapasons
    @StructuredCablingStudioParameters XML OUTPUT
AS
BEGIN
    DECLARE @IsStrictComplianceWithTheStandart BIT;
    DECLARE @IsAnArbitraryNumberOfPorts BIT;

    DECLARE @StructuredCablingStudioDiapasons XML;

    SET @IsStrictComplianceWithTheStandart = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsStrictComplianceWithTheStandart)[1]', 'bit');
    SET @IsAnArbitraryNumberOfPorts = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsAnArbitraryNumberOfPorts)[1]', 'bit');

    SET @StructuredCablingStudioDiapasons = Calculation.GetStructuredCablingStudioParametersDiapasons(@IsStrictComplianceWithTheStandart,
                                                                                                @IsAnArbitraryNumberOfPorts);
                                                                                                
    SET @StructuredCablingStudioParameters.modify('
        insert sql:variable("@StructuredCablingStudioDiapasons")
        into (/StructuredCablingStudioParameters)[1]
    ');

END;