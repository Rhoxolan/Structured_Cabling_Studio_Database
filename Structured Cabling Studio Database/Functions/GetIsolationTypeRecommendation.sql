CREATE FUNCTION GetIsolationTypeRecommendation(@IsolationType NVARCHAR(MAX))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Recommendation NVARCHAR(50);

    SELECT @Recommendation = Recommendation
    FROM IsolationTypeRecommendations
    WHERE IsolationType = @IsolationType;

    RETURN @Recommendation;
END