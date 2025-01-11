CREATE FUNCTION Calculation.GetCableStandardRecommendation(@ConnectionInterfaces XML)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Recommendation NVARCHAR(50);

    SELECT TOP 1 @Recommendation = Calculation.CableStandardRecommendations.Recommendation
    FROM Calculation.CableStandardRecommendations,
        @ConnectionInterfaces.nodes('/ConnectionInterfaces/ConnectionInterfaceStandard') AS CI(ConnectionInterface)
    WHERE Calculation.CableStandardRecommendations.ConnectionInterfaceStandard = CI.ConnectionInterface.value('.', 'NVARCHAR(MAX)')
    ORDER BY Calculation.CableStandardRecommendations.[Order] DESC;

    RETURN @Recommendation;
END