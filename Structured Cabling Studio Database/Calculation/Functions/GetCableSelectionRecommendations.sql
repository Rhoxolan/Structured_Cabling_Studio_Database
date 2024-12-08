CREATE FUNCTION Calculate.GetCableSelectionRecommendations(@RecommendationsArguments XML)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Recommendations NVARCHAR(MAX);

    DECLARE @IsolationType NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/IsolationType)[1]', 'nvarchar(max)');
    DECLARE @IsolationMaterial NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/IsolationMaterial)[1]', 'nvarchar(max)');
    DECLARE @ShieldedType NVARCHAR(MAX) = @RecommendationsArguments.value('(/RecommendationsArguments/ShieldedType)[1]', 'nvarchar(max)');
    DECLARE @ConnectionInterfaces XML = @RecommendationsArguments.value('(/RecommendationsArguments/ConnectionInterfaces)[1]', 'xml');

    DECLARE @RecommendationIsolationType NVARCHAR(50);
    DECLARE @RecommendationIsolationMaterial NVARCHAR(50);
    DECLARE @RecommendationShieldedType NVARCHAR(50);
    DECLARE @RecommendationCableStandard NVARCHAR(50);

    SELECT @RecommendationIsolationType = Calculate.GetIsolationTypeRecommendation(@IsolationType);
    SELECT @RecommendationIsolationMaterial = Calculate.GetIsolationMaterialRecommendation(@IsolationMaterial);
    SELECT @RecommendationShieldedType = Calculate.GetShieldedTypeRecommendation(@ShieldedType);
    SELECT @RecommendationCableStandard = Calculate.GetCableStandardRecommendation(@ConnectionInterfaces);

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