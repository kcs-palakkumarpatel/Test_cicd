
CREATE PROCEDURE [settings].[AuthPrincipalCreate]
    @name NVARCHAR(MAX),
    @principalType INT,
    @principalRole INT,
    @all BIT,
    @authenticationType INT
AS
    BEGIN
        DECLARE @id INT;
        SET NOCOUNT ON;

        BEGIN TRANSACTION;
        BEGIN
            INSERT  INTO [settings].[AuthPrincipals]
                    ([Name],
                     [PrincipalType],
                     [PrincipalRole],
                     [All],
                     [AuthenticationType]
                    )
            VALUES  (@name,
                     @principalType,
                     @principalRole,
                     @all,
                     @authenticationType
                    );

            SET @id = (SELECT   Id
                       FROM     [settings].[AuthPrincipals]
                       WHERE    Id = @@Identity
                      );

        END
        COMMIT TRANSACTION;

        RETURN @id;
    END;