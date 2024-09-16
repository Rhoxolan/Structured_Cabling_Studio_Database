CREATE PROCEDURE SetAuthorizationSessionContext
    @UserId NVARCHAR(450) = NULL INPUT
AS
    EXEC sp_set_session_context 'UserId', @UserId;
