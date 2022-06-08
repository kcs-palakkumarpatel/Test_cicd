
CREATE PROCEDURE [settings].[AuthPrincipalAuthorizationDelete]
    @principalId INT
AS
    BEGIN
        SET NOCOUNT ON;

        BEGIN TRANSACTION
        BEGIN

			DELETE FROM [settings].[AuthPrincipalAuthorizations]
			 WHERE AuthPrincipalsId = @principalId;

        END
        COMMIT TRANSACTION
    END;