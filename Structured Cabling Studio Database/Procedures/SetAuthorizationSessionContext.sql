CREATE PROCEDURE SetAuthorizationSessionContext
    @UserId NVARCHAR(450) = NULL
AS
    EXEC sp_set_session_context 'UserId', @UserId;
