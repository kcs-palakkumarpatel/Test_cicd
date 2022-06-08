
CREATE PROCEDURE [settings].[AuthPrincipalUpdate]
    @id INT,
    @name NVARCHAR(MAX),
    @principalType INT,
    @principalRole INT,
    @all BIT,
    @authenticationType INT
AS
    BEGIN
        SET NOCOUNT ON;

        BEGIN TRANSACTION;
        BEGIN
            UPDATE  [settings].[AuthPrincipals]
            SET     [Name] = @name,
                    [PrincipalType] = @principalType,
                    [PrincipalRole] = @principalRole,
                    [All] = @all,
                    [AuthenticationType] = @authenticationType
            WHERE   [Id] = @id;

            IF (@@ROWCOUNT != 1)
                BEGIN
                    RAISERROR ('Incorrect number of principals updated.', 15, 1 )

                END;
        END
        COMMIT TRANSACTION;
    END
