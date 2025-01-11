CREATE PROCEDURE Calculation.CalculateStructuredCablingConfiguration
    @ConfigurationCalculateParameters XML,
    @StructuredCablingStudioParameters XML,
    @RecordTime DATETIME2,
    @MinPermanentLink FLOAT(1),
    @MaxPermanentLink FLOAT(1),
    @NumberOfWorkplaces INT,
    @NumberOfPorts INT,
    @CablingConfiguration XML OUTPUT
AS
BEGIN
    DECLARE @CableHankMeterage INT;
    DECLARE @IsCableHankMeterageAvailability BIT;

    DECLARE @TechnologicalReserve FLOAT(1);
    DECLARE @IsRecommendationsAvailability BIT;
    DECLARE @IsStrictComplianceWithTheStandart BIT;
    DECLARE @IsAnArbitraryNumberOfPorts BIT;
    DECLARE @IsTechnologicalReserveAvailability BIT;
    DECLARE @RecommendationsArguments XML;

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
    SET @RecommendationsArguments = @StructuredCablingStudioParameters.query('(/StructuredCablingStudioParameters/RecommendationsArguments)[1]');

    SET @CablingConfigurationCalculatedData = CASE
                                    WHEN @IsCableHankMeterageAvailability = 1
                                        THEN Calculation.CalculateConfigurationWithHankMeterage(@MinPermanentLink,
                                                                                    @MaxPermanentLink,
                                                                                    @NumberOfWorkplaces,
                                                                                    @NumberOfPorts,
                                                                                    @CableHankMeterage,
                                                                                    @TechnologicalReserve,
                                                                                    @IsRecommendationsAvailability,
                                                                                    @IsStrictComplianceWithTheStandart,
                                                                                    @IsAnArbitraryNumberOfPorts,
                                                                                    @IsTechnologicalReserveAvailability,
                                                                                    @RecommendationsArguments)
                                    ELSE Calculation.CalculateConfigurationWithoutHankMeterage(@MinPermanentLink,
                                                                                    @MaxPermanentLink,
                                                                                    @NumberOfWorkplaces,
                                                                                    @NumberOfPorts,
                                                                                    @TechnologicalReserve,
                                                                                    @IsRecommendationsAvailability,
                                                                                    @IsStrictComplianceWithTheStandart,
                                                                                    @IsAnArbitraryNumberOfPorts,
                                                                                    @IsTechnologicalReserveAvailability,
                                                                                    @RecommendationsArguments)
                                END;

    IF @CablingConfigurationCalculatedData.exist('/CablingConfigurationCalculatedData[Status="Fault"]') = 1
    BEGIN
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SELECT @ErrorMessage = @CablingConfigurationCalculatedData.value('(/CablingConfigurationCalculatedData/ErrorMessage)[1]', 'NVARCHAR(MAX)');
        THROW 51000, @ErrorMessage, 1;
    END;

    SET @AveragePermanentLink = @CablingConfigurationCalculatedData.value('(/CablingConfigurationCalculatedData/AveragePermanentLink)[1]', 'float');
    SET @CableQuantity = @CablingConfigurationCalculatedData.value('(/CablingConfigurationCalculatedData/CableQuantity)[1]', 'float');
    SET @HankQuantity = @CablingConfigurationCalculatedData.value('(/CablingConfigurationCalculatedData/HankQuantity)[1]', 'int');
    SET @TotalCableQuantity = @CablingConfigurationCalculatedData.value('(/CablingConfigurationCalculatedData/TotalCableQuantity)[1]', 'float');
    SET @Recommendations = @CablingConfigurationCalculatedData.value('(/CablingConfigurationCalculatedData/Recommendations)[1]', 'nvarchar(max)');

    SET @UserId = CAST(SESSION_CONTEXT(N'UserId') AS NVARCHAR(450));

    IF @UserId IS NOT NULL
    BEGIN
        DECLARE @InsertedIds TABLE (Id BIGINT);

        INSERT INTO Calculation.CablingConfigurations(UserId, RecordTime, MinPermanentLink, MaxPermanentLink, AveragePermanentLink, NumberOfWorkplaces, NumberOfPorts, CableQuantity,
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