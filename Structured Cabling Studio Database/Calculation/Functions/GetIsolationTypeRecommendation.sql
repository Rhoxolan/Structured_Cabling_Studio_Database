CREATE FUNCTION Calculate.GetIsolationTypeRecommendation(@IsolationType NVARCHAR(MAX))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Recommendation NVARCHAR(50);

    SELECT @Recommendation = Recommendation
    FROM Calculate.IsolationTypeRecommendations
    WHERE IsolationType = @IsolationType;

    RETURN @Recommendation;
END