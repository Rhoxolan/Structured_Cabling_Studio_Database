CREATE PROCEDURE CalculateStructuredCablingConfiguration
    @ConfigurationCalculateParameters XML INPUT,
    @StructuredCablingStudioParameters XML INPUT,
    @RecordTime DATETIME2 INPUT,
    @MinPermanentLink FLOAT(1) INPUT,
    @MaxPermanentLink FLOAT(1) INPUT,
    @NumberOfWorkplaces INT INPUT,
    @NumberOfPorts INT INPUT,
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

    SET @CablingConfiguration = CASE
                                    WHEN @IsCableHankMeterageAvailability = 1
                                        THEN CalculateConfigurationWithHankMeterage(@MinPermanentLink,
                                                                                    @MaxPermanentLink,
                                                                                    @NumberOfWorkplaces,
                                                                                    @NumberOfPorts,
                                                                                    @RecordTime,
                                                                                    @CableHankMeterage,
                                                                                    @TechnologicalReserve,
                                                                                    @IsRecommendationsAvailability,
                                                                                    @IsStrictComplianceWithTheStandart,
                                                                                    @IsAnArbitraryNumberOfPorts,
                                                                                    @IsTechnologicalReserveAvailability)
                                    ELSE CalculateConfigurationWithoutHankMeterage(@MinPermanentLink,
                                                                                    @MaxPermanentLink,
                                                                                    @NumberOfWorkplaces,
                                                                                    @NumberOfPorts,
                                                                                    @RecordTime,
                                                                                    @TechnologicalReserve,
                                                                                    @IsRecommendationsAvailability,
                                                                                    @IsStrictComplianceWithTheStandart,
                                                                                    @IsAnArbitraryNumberOfPorts,
                                                                                    @IsTechnologicalReserveAvailability
                                                                                    )
                                END;

END;