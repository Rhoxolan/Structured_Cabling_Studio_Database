CREATE FUNCTION CalculateConfigurationWithHankMeterage(
    @MinPermanentLink FLOAT(1),
    @MaxPermanentLink FLOAT(1),
    @NumberOfWorkplaces INT,
    @NumberOfPorts INT,
    @CableHankMeterage INT,
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

    IF @CableHankMeterage IS NULL
    BEGIN
        THROW 51000, 'Structured cabling configuration calculating error! Value of cable meterage in 1 hank is not determined', 1;
    END

    DECLARE @AveragePermanentLink FLOAT(1) = (@MinPermanentLink + @MaxPermanentLink) / 2 * @TechnologicalReserve;

    IF @AveragePermanentLink > @CableHankMeterage
    BEGIN
        THROW 51000, 'Calculation is impossible! The value of average permanent link length more than the value of cable hank meterage', 1;
    END

    DECLARE @CableQuantity FLOAT(1) = @AveragePermanentLink * @NumberOfWorkplaces * @NumberOfPorts;
    DECLARE @HankQuantity INT = CAST(CEILING(@NumberOfWorkplaces * @NumberOfPorts / FLOOR(@CableHankMeterage / @AveragePermanentLink)) AS INT);
    DECLARE @TotalCableQuantity FLOAT(1) = @HankQuantity * @CableHankMeterage;
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
            @CableQuantity AS 'CableQuantity',
            @HankQuantity AS 'HankQuantity',
            @TotalCableQuantity AS 'TotalCableQuantity',
            @Recommendations AS 'Recommendations'
        FOR XML PATH('CablingConfigurationCalculatedData'), TYPE
    );

    RETURN @CablingConfigurationCalculatedData;

END