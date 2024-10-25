CREATE FUNCTION CalculateConfigurationWithoutHankMeterage(
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
        DECLARE @IsolationType NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/IsolationType)[1]', 'nvarchar(max)');
        DECLARE @IsolationMaterial NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/IsolationMaterial)[1]', 'nvarchar(max)');
        DECLARE @ShieldedType NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/ShieldedType)[1]', 'nvarchar(max)');
        DECLARE @ConnectionInterfaces XML = @RecommendationsArguments.value('(/RecommendationsArguments/ConnectionInterfaces)[1]', 'xml');

        DECLARE @RecommendationIsolationType NVARCHAR(50);
        DECLARE @RecommendationIsolationMaterial NVARCHAR(50);
        DECLARE @RecommendationShieldedType NVARCHAR(50);
        DECLARE @RecommendationCableStandard NVARCHAR(50);

        SELECT @RecommendationIsolationType = GetIsolationTypeRecommendation(@IsolationType);
        SELECT @RecommendationIsolationMaterial = GetIsolationMaterialRecommendation(@IsolationMaterial);
        SELECT @RecommendationShieldedType = GetShieldedTypeRecommendation(@ShieldedType);
        SELECT @RecommendationCableStandard = GetCableStandardRecommendation(@ShieldedType);

        SET @Recommendations = (
            SELECT
                @RecommendationIsolationType AS RecommendationIsolationType,
                @RecommendationIsolationMaterial AS RecommendationIsolationMaterial,
                @RecommendationShieldedType AS RecommendationShieldedType,
                @RecommendationCableStandard AS RecommendationCableStandard
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
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