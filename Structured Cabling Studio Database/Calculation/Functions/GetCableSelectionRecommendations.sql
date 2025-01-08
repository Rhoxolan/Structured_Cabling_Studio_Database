CREATE FUNCTION Calculation.GetCableSelectionRecommendations(@RecommendationsArguments XML)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Recommendations NVARCHAR(MAX);

    DECLARE @IsolationType NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/IsolationType)[1]', 'nvarchar(max)');
    DECLARE @IsolationMaterial NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/IsolationMaterial)[1]', 'nvarchar(max)');
    DECLARE @ShieldedType NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/ShieldedType)[1]', 'nvarchar(max)');
    DECLARE @ConnectionInterfaces XML = @RecommendationsArguments.query('(/RecommendationsArguments/ConnectionInterfaces)[1]');

    DECLARE @RecommendationIsolationType NVARCHAR(50);
    DECLARE @RecommendationIsolationMaterial NVARCHAR(50);
    DECLARE @RecommendationShieldedType NVARCHAR(50);
    DECLARE @RecommendationCableStandard NVARCHAR(50);

    SELECT @RecommendationIsolationType = Calculation.GetIsolationTypeRecommendation(@IsolationType),
        @RecommendationIsolationMaterial = Calculation.GetIsolationMaterialRecommendation(@IsolationMaterial),
        @RecommendationShieldedType = Calculation.GetShieldedTypeRecommendation(@ShieldedType),
        @RecommendationCableStandard = Calculation.GetCableStandardRecommendation(@ConnectionInterfaces);

    SET @Recommendations = (
        SELECT
            @RecommendationIsolationType AS RecommendationIsolationType,
            @RecommendationIsolationMaterial AS RecommendationIsolationMaterial,
            @RecommendationShieldedType AS RecommendationShieldedType,
            @RecommendationCableStandard AS RecommendationCableStandard
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    RETURN @Recommendations;
END