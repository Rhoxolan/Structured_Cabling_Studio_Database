CREATE FUNCTION Calculate.CalculateConfigurationWithoutHankMeterage(
    @MinPermanentLink FLOAT(1),
    @MaxPermanentLink FLOAT(1),
    @NumberOfWorkplaces INT,
    @NumberOfPorts INT,
    @TechnologicalReserve FLOAT(1),
    @IsRecommendationsAvailability BIT,
    @IsStrictComplianceWithTheStandart BIT,
    @IsAnArbitraryNumberOfPorts BIT,
    @IsTechnologicalReserveAvailability BIT,
    @RecommendationsArguments XML
)
RETURNS XML
AS
BEGIN
    DECLARE @CablingConfigurationCalculatedData XML;

    DECLARE @AveragePermanentLink FLOAT(1) = (@MinPermanentLink + @MaxPermanentLink) / 2 * @TechnologicalReserve;
    DECLARE @TotalCableQuantity FLOAT(1) = @HankQuantity * @CableHankMeterage * @NumberOfPorts;
    DECLARE @Recommendations NVARCHAR(MAX);

    IF @IsRecommendationsAvailability = 1
    BEGIN
        SELECT @Recommendations = Calculate.GetCableSelectionRecommendations(@RecommendationsArguments);
    END

    SET @CablingConfigurationCalculatedData = (
        SELECT
            @AveragePermanentLink AS 'AveragePermanentLink',
            @TotalCableQuantity AS 'TotalCableQuantity',
            @Recommendations AS 'Recommendations'
        FOR XML PATH('CablingConfigurationCalculatedData'), TYPE
    );

    RETURN @CablingConfigurationCalculatedData;

END