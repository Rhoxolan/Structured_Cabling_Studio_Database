CREATE FUNCTION GetIsolationTypeRecommendation(@IsolationType NVARCHAR(MAX))
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN CASE @IsolationType
            WHEN 'Indoor' THEN 'Indoor'
            WHEN 'Outdoor' THEN 'Outdoor'
    END
END