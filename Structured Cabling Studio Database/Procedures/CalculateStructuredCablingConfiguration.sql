CREATE PROCEDURE CalculateStructuredCablingConfiguration
    @ConfigurationCalculateParameters XML INPUT,
    @StructuredCablingStudioParameters XML INPUT,
    @RecordTime DATETIME2 INPUT,
    @MinPermanentLink FLOAT(1) INPUT,
    @MaxPermanentLink FLOAT(1) INPUT,
    @NumberOfWorkplaces INT INPUT,
    @NumberOfPorts INT INPUT,
    @CablingConfiguration XML OUTPUT
AS
BEGIN
    DECLARE @CableHankMeterage INT;
    DECLARE @IsCableHankMeterageAvailability BIT;

    DECLARE @TechnologicalReserve FLOAT;
    DECLARE @IsRecommendationsAvailability BIT;
    DECLARE @IsStrictComplianceWithTheStandart BIT;
    DECLARE @IsAnArbitraryNumberOfPorts BIT;
    DECLARE @IsTechnologicalReserveAvailability BIT;

    DECLARE @CablingConfigurationCalculatedData XML;

    DECLARE @AveragePermanentLink FLOAT(1);
    DECLARE @CableQuantity FLOAT(1);
    DECLARE @HankQuantity INT;
    DECLARE @TotalCableQuantity FLOAT(1);
    DECLARE @Recommendations NVARCHAR(MAX);

    DECLARE @Id BIGINT;
    DECLARE @UserId NVARCHAR(450);

    SET @CableHankMeterage = @ConfigurationCalculateParameters.value('(/ConfigurationCalculateParameters/CableHankMeterage)[1]', 'int');
    SET @IsCableHankMeterageAvailability = @ConfigurationCalculateParameters.value('(/ConfigurationCalculateParameters/IsCableHankMeterageAvailability)[1]', 'bit');

    SET @TechnologicalReserve = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/TechnologicalReserve)[1]', 'float');
    SET @IsRecommendationsAvailability = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsRecommendationsAvailability)[1]', 'bit');
    SET @IsStrictComplianceWithTheStandart = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsStrictComplianceWithTheStandart)[1]', 'bit');
    SET @IsAnArbitraryNumberOfPorts = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsAnArbitraryNumberOfPorts)[1]', 'bit');
    SET @IsTechnologicalReserveAvailability = @StructuredCablingStudioParameters.value('(/StructuredCablingStudioParameters/IsTechnologicalReserveAvailability)[1]', 'bit');

    SET @CablingConfigurationCalculatedData = CASE
                                    WHEN @IsCableHankMeterageAvailability = 1
                                        THEN CalculateConfigurationWithHankMeterage(@MinPermanentLink,
                                                                                    @MaxPermanentLink,
                                                                                    @NumberOfWorkplaces,
                                                                                    @NumberOfPorts,
                                                                                    @CableHankMeterage,
                                                                                    @TechnologicalReserve,
                                                                                    @IsRecommendationsAvailability,
                                                                                    @IsStrictComplianceWithTheStandart,
                                                                                    @IsAnArbitraryNumberOfPorts,
                                                                                    @IsTechnologicalReserveAvailability)
                                    ELSE CalculateConfigurationWithoutHankMeterage(@MinPermanentLink,
                                                                                    @MaxPermanentLink,
                                                                                    @NumberOfWorkplaces,
                                                                                    @NumberOfPorts,
                                                                                    @TechnologicalReserve,
                                                                                    @IsRecommendationsAvailability,
                                                                                    @IsStrictComplianceWithTheStandart,
                                                                                    @IsAnArbitraryNumberOfPorts,
                                                                                    @IsTechnologicalReserveAvailability)
                                END;

    SET @AveragePermanentLink = @CablingConfigurationCalculatedData.value('(/Data/AveragePermanentLink)[1]', 'float');
    SET @CableQuantity = @CablingConfigurationCalculatedData.value('(/Data/CableQuantity)[1]', 'float');
    SET @HankQuantity = @CablingConfigurationCalculatedData.value('(/Data/HankQuantity)[1]', 'int');
    SET @TotalCableQuantity = @CablingConfigurationCalculatedData.value('(/Data/TotalCableQuantity)[1]', 'float');
    SET @Recommendations = @CablingConfigurationCalculatedData.value('(/Data/Recommendations)[1]', 'nvarchar(max)');

    SET @UserId = CAST(SESSION_CONTEXT(N'UserId') AS NVARCHAR(450));

    IF @UserId IS NOT NULL
    BEGIN
        DECLARE @InsertedIds TABLE (Id BIGINT);

        INSERT INTO CablingConfigurations(UserId, RecordTime, MinPermanentLink, MaxPermanentLink, AveragePermanentLink, NumberOfWorkplaces, NumberOfPorts, CableQuantity,
                                            CableHankMeterage, HankQuantity, TotalCableQuantity, Recommendations)
        OUTPUT inserted.Id INTO InsertedIds
        VALUES(@UserId, @RecordTime, @MinPermanentLink, @MaxPermanentLink, @AveragePermanentLink, @NumberOfWorkplaces, @NumberOfPorts, @CableQuantity, @CableHankMeterage,
                @HankQuantity, @TotalCableQuantity, @Recommendations)
        
        SET @Id = (SELECT Id FROM @InsertedIds);
    END

    SET @CablingConfiguration = (
        SELECT
            @Id AS 'Id',
            @UserId AS 'UserId',
            @RecordTime AS 'RecordTime',
            @MinPermanentLink AS 'MinPermanentLink',
            @MaxPermanentLink AS 'MaxPermanentLink',
            @AveragePermanentLink AS 'AveragePermanentLink',
            @NumberOfWorkplaces AS 'NumberOfWorkplaces',
            @NumberOfPorts AS 'NumberOfPorts',
            @CableQuantity AS 'CableQuantity',
            @CableHankMeterage AS 'CableHankMeterage',
            @HankQuantity AS 'HankQuantity',
            @TotalCableQuantity AS 'TotalCableQuantity',
            @Recommendations AS 'Recommendations'
        FOR XML PATH('CablingConfiguration'), TYPE
    );

END;