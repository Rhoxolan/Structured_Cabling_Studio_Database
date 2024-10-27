--Schemas
:R "..\Scripts\CreateSchemas.sql"

--Tables
:R "..\Scripts\IdentityInitialize.sql"
--Calculation
:R "..\Calculation\Tables\CablingConfigurations.sql"
:R "..\Calculation\Tables\CableStandardRecommendations.sql"
:R "..\Calculation\Tables\IsolationMaterialRecommendations.sql"
:R "..\Calculation\Tables\IsolationTypeRecommendations.sql"
:R "..\Calculation\Tables\ShieldedTypeRecommendations.sql"

--Functions
--Calculation
:R "..\Calculation\Functions\CalculateConfigurationWithHankMeterage.sql"
:R "..\Calculation\Functions\CalculateConfigurationWithoutHankMeterage.sql"
:R "..\Calculation\Functions\GetCableSelectionRecommendations.sql"
:R "..\Calculation\Functions\GetCableStandardRecommendation.sql"
:R "..\Calculation\Functions\GetIsolationMaterialRecommendation.sql"
:R "..\Calculation\Functions\GetIsolationTypeRecommendation.sql"
:R "..\Calculation\Functions\GetShieldedTypeRecommendation.sql"


--Procedures
--Calculation
:R "..\Calculation\Procedures\SetAuthorizationSessionContext.sql"
:R "..\Calculation\Procedures\CalculateStructuredCablingConfiguration.sql"

--Seed Data
:R "..\Scripts\SeedRecommendations.sql"