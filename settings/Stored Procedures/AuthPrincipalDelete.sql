
CREATE PROCEDURE [settings].[AuthPrincipalDelete] @id INT
AS
    BEGIN
        SET NOCOUNT ON;

        BEGIN TRANSACTION;
        BEGIN
            DECLARE @currentRecordPrincipalRole INT;

            SELECT  @currentRecordPrincipalRole = [PrincipalRole]
            FROM    [settings].[AuthPrincipals]
            WHERE   [Id] = @id;

            IF (@currentRecordPrincipalRole = 1)
                BEGIN
                    DECLARE @admins INT;

                    SELECT  @admins = COUNT(*)
                    FROM    [settings].[AuthPrincipals]
                    WHERE   [PrincipalRole] = 1;

                    IF (@admins <= 1)
                        BEGIN
                            RAISERROR ('Unable to delete the last administrator.', 15, 2 )
                        END;
                END;

            DELETE  FROM [settings].[AuthPrincipals]
            WHERE   [Id] = @id;

            IF (@@ROWCOUNT != 1)
                BEGIN
                    RAISERROR ('Incorrect number of principals deleted.', 15, 3 )
                END
        END
        COMMIT TRANSACTION
    END