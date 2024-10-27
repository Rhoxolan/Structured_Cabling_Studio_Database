CREATE FUNCTION Calculate.GetCableStandardRecommendation(@ConnectionInterfaces XML)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Recommendation NVARCHAR(50);

    SELECT TOP 1 @Recommendation = Calculate.CableStandardRecommendations.Recommendation
    FROM Calculate.CableStandardRecommendations,
        @ConnectionInterfaces.nodes('/ConnectionInterfaces/ConnectionInterface') AS ConnectionInterfaces
    WHERE Calculate.CableStandardRecommendations.ConnectionInterfaceStandard = ConnectionInterfaces.value('.', 'NVARCHAR(MAX)')
    ORDER BY Calculate.CableStandardRecommendations.Order DESC;

    RETURN @Recommendation;
END