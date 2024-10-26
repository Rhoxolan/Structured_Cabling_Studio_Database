CREATE FUNCTION GetCableStandardRecommendation(@ConnectionInterfaces XML)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Recommendation NVARCHAR(50);

    SELECT TOP 1 @Recommendation = CableStandardRecommendations.Recommendation
    FROM CableStandardRecommendations,
        @ConnectionInterfaces.nodes('/ConnectionInterfaces/ConnectionInterface') AS ConnectionInterfaces
    WHERE CableStandardRecommendations.ConnectionInterfaceStandard = ConnectionInterfaces.value('.', 'NVARCHAR(MAX)')
    ORDER BY CableStandardRecommendations.Order DESC;

    RETURN @Recommendation;
END