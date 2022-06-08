
CREATE PROCEDURE [settings].[AuthPrincipalAuthorizationCreate]
    @principalId INT,
    @groupName NVARCHAR(255),
    @clusterName NVARCHAR(MAX),
    @azureSqlServerName NVARCHAR(255),
    @azureManagedInstanceName NVARCHAR(255),
    @amazonRdsSqlServerName NVARCHAR(255)
AS
    BEGIN
        DECLARE @id INT;
        DECLARE @groupId UNIQUEIDENTIFIER;
        DECLARE @clusterId UNIQUEIDENTIFIER;
        DECLARE @azureSqlServerId UNIQUEIDENTIFIER;
        DECLARE @azureManagedInstanceId UNIQUEIDENTIFIER;
        DECLARE @amazonRdsSqlServerId UNIQUEIDENTIFIER;
        SET NOCOUNT ON;

        BEGIN TRANSACTION
        BEGIN
            SELECT @groupId = GroupId  FROM    settings.[Group]  WHERE   Name = @groupName;
            SELECT @clusterId = Id  FROM    settings.Clusters  WHERE   Name = @clusterName;
            SELECT @azureSqlServerId = Id FROM settings.AzureSqlServers WHERE Name = @azureSqlServerName;
            SELECT @azureManagedInstanceId = Id FROM settings.AzureManagedInstances WHERE Name = @azureManagedInstanceName;
            SELECT @amazonRdsSqlServerId = Id FROM settings.AmazonRdsSqlServers WHERE Name = @amazonRdsSqlServerName;

			IF @groupId IS NULL AND @groupName IS NOT NULL
			BEGIN
               RAISERROR ('Group name is invalid', 15, 4 )
            END
			IF @clusterId IS NULL AND @clusterName IS NOT NULL
			BEGIN
                RAISERROR ('Cluster name is invalid', 15, 5 )

            END
            IF @azureSqlServerId IS NULL AND @azureSqlServerName IS NOT NULL
			BEGIN
                RAISERROR ('Azure SQL Server name is invalid', 15, 5 )

            END
            IF @azureManagedInstanceId IS NULL AND @azureManagedInstanceName IS NOT NULL
            BEGIN
                RAISERROR ('Azure Managed Instance name is invalid', 15, 5 )

            END
            IF @amazonRdsSqlServerId IS NULL AND @amazonRdsSqlServerName IS NOT NULL
            BEGIN
                RAISERROR ('Amazon RDS SQL Server name is invalid', 15, 5 )

            END

			IF @groupId IS NULL AND @clusterId IS NULL AND @azureSqlServerId IS NULL AND @azureManagedInstanceId IS NULL AND @amazonRdsSqlServerId IS NULL
			BEGIN
                RAISERROR ('You need to specify either a valid Cluster name, Azure SQL Server name, Amazon RDS SQL Server name or Group name', 15, 6 )
			END
			ELSE
			BEGIN

				INSERT  INTO [settings].[AuthPrincipalAuthorizations]
						([AuthPrincipalsId],
						 [GroupId],
						 [ClusterId],
						 [AzureSqlServerId],
                         [AzureManagedInstanceId],
						 [AmazonRdsSqlServerId]
						)
				VALUES  (@principalId,
						 @groupId,
						 @clusterId,
						 @azureSqlServerId,
						 @azureManagedInstanceId,
						 @amazonRdsSqlServerId
						);

				SET @id = (SELECT   AuthorizationId
						   FROM     [settings].[AuthPrincipalAuthorizations]
						   WHERE    AuthorizationId = @@Identity
						  );
			END
        END
        COMMIT TRANSACTION

        RETURN @id;
    END
