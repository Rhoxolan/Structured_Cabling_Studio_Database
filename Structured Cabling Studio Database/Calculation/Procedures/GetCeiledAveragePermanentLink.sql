CREATE PROCEDURE Calculation.CalculateCeiledAveragePermanentLink
    @MinPermanentLink FLOAT(1),
    @MaxPermanentLink FLOAT(1),
    @TechnologicalReserve FLOAT(1),
    @CeiledAveragePermanentLink INT OUTPUT
AS
BEGIN
    SET @CeiledAveragePermanentLink = Calculation.GetCeiledAveragePermanentLink(@MinPermanentLink,
                                                                                    @MaxPermanentLink,
                                                                                    @TechnologicalReserve);

END;