CREATE FUNCTION GetIsolationMaterialRecommendation(@IsolationMaterial NVARCHAR(MAX))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Recommendation NVARCHAR(50);

    SELECT @Recommendation = Recommendation
    FROM IsolationMaterialRecommendations
    WHERE IsolationMaterial = @IsolationMaterial;

    RETURN @Recommendation;
END