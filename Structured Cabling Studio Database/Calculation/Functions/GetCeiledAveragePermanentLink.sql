CREATE FUNCTION Calculation.GetCeiledAveragePermanentLink(
    @MinPermanentLink FLOAT(1),
    @MaxPermanentLink FLOAT(1),
    @TechnologicalReserve FLOAT(1)
)
RETURNS INT
AS
BEGIN
    RETURN CAST(CEILING((@MinPermanentLink + @MaxPermanentLink) / 2 * @TechnologicalReserve) AS INT);
END