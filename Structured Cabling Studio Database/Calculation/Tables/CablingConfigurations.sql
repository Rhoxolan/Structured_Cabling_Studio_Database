CREATE TABLE Calculation.CablingConfigurations (
    Id BIGINT PRIMARY KEY IDENTITY NOT NULL,
    UserId NVARCHAR(450) REFERENCES AspNetUsers(Id) ON DELETE CASCADE NULL,
    RecordTime DATETIME2 NOT NULL, -- Record time of the structured cabling configuration record
    MinPermanentLink FLOAT(1) NOT NULL, -- Value of permanent link minimum length in the structured cabling configuration record
    MaxPermanentLink FLOAT(1) NOT NULL, -- Value of permanent link maximum length in the structured cabling configuration record
    AveragePermanentLink FLOAT(1) NOT NULL, -- Value of permanent link average length in the structured cabling configuration record
    NumberOfWorkplaces INT NOT NULL, -- Value of workplaces count in the structured cabling configuration record
    NumberOfPorts INT NOT NULL, -- Value of ports count per 1 workplace in the structured cabling configuration record
    CableQuantity FLOAT(1) NULL, -- Value of necessary cable meterage for structured cabling installation, in the structured cabling configuration record
    CableHankMeterage INT NULL, -- Value of cable hank meterage in the structured cabling configuration record
    HankQuantity INT NULL, -- Value of cable hank count in the structured cabling configuration record
    TotalCableQuantity FLOAT(1) NOT NULL, -- Value of the total necessary cable meterage for structured cabling installation, in the structured cabling configuration record
    Recommendations NVARCHAR(MAX) NOT NULL -- Recommendations for cable selection in the structured cabling configuration record
)