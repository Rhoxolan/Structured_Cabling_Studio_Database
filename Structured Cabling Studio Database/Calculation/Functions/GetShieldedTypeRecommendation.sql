CREATE FUNCTION Calculate.GetShieldedTypeRecommendation(@ShieldedType NVARCHAR(MAX))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Recommendation NVARCHAR(50);

    SELECT @Recommendation = Recommendation
    FROM Calculate.ShieldedTypeRecommendations
    WHERE ShieldedType = @ShieldedType;

    RETURN @Recommendation;
END