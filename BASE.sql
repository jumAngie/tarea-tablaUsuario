CREATE DATABASE DB_USUARIOS

GO
USE DB_USUARIOS


CREATE TABLE tbUsuarios
( usu_Id					INT IDENTITY(1,1) PRIMARY KEY,
usu_Nambe					NVARCHAR(150) NOT NULL,
usu_Apellido				NVARCHAR(150) NOT NULL,
usu_UsuarioAlias			NVARCHAR(150) NOT NULL,
usu_Contra					NVARCHAR(MAX) NOT NULL,
usu_EsAdmin					BIT NOT NULL,					
usu_UsuCrea					INT NOT NULL,
usu_FechaCrea			    DATETIME NOT NULL,
usu_UsuModif				INT,
usu_FechaModif				DATETIME,
usu_Estado					BIT NOT NULL
);


GO
CREATE OR ALTER PROCEDURE UDP_USUARIOS_INSERT
@usu_Nambe NVARCHAR(150), 
@usu_Apellido NVARCHAR(150),
@usu_UsuarioAlias NVARCHAR(150), 
@usu_Contra NVARCHAR(MAX),
@usu_EsAdmin BIT, 
@usu_UsuCrea INT

AS
BEGIN

DECLARE @usu_FechaCrea DATETIME = GETDATE();
DECLARE @usu_UsuModif INT = NULL; 
DECLARE @usu_FechaModif DATETIME = NULL;
DECLARE @usu_Estado BIT = 1;
DECLARE @Pass NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_512',@usu_Contra),2);

INSERT INTO [dbo].[tbUsuarios] ([usu_Nambe], [usu_Apellido], [usu_UsuarioAlias], [usu_Contra], [usu_EsAdmin], [usu_UsuCrea], [usu_FechaCrea], [usu_UsuModif], [usu_FechaModif], [usu_Estado])
VALUES						(@usu_Nambe, @usu_Apellido, @usu_UsuarioAlias, @Pass, @usu_EsAdmin, @usu_UsuCrea, @usu_FechaCrea, @usu_UsuModif, @usu_FechaModif, @usu_Estado)

END

GO

EXEC UDP_USUARIOS_INSERT 'Karla','Alejandro','Meow','1106',1,1


ALTER TABLE [dbo].[tbUsuarios]
ADD CONSTRAINT FK_tbUsuarios_usuCrea FOREIGN KEY (usu_UsuCrea) REFERENCES [dbo].[tbUsuarios] (usu_Id)

ALTER TABLE [dbo].[tbUsuarios]
ADD CONSTRAINT FK_tbUsuarios_usuModif FOREIGN KEY (usu_UsuModif) REFERENCES [dbo].[tbUsuarios] (usu_Id)



EXEC UDP_USUARIOS_INSERT 'Dania','Baca','Karly','1401',1,1
EXEC UDP_USUARIOS_INSERT 'Jose','Martinez','oso','2121',0,1



CREATE OR ALTER VIEW V_USARIOS_INDEX
AS
SELECT
[usu_Id], [usu_Nambe] , [usu_Apellido] , [usu_UsuarioAlias] ,  
CASE	[usu_EsAdmin]
		WHEN 1 THEN 'Si'
		when 0 THEN 'No'
		ELSE 'No sabo' END AS [usu_EsAdmin]
FROM tbUsuarios
WHERE [usu_Estado] = 1


SELECT*FROM V_USARIOS_INDEX





GO
CREATE OR ALTER PROCEDURE UDP_VALIDAR_LOGIN
@usu_Alias  NVARCHAR(150),
@usu_Contra  NVARCHAR(MAX)

AS
BEGIN

DECLARE @Pass NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_512',@usu_Contra),2);

SELECT [usu_Id], [usu_UsuarioAlias], [usu_Contra]
FROM [dbo].[tbUsuarios]
WHERE [usu_UsuarioAlias] = @usu_Alias AND
[usu_Contra] = @Pass

END


 GO


 EXEC UDP_VALIDAR_LOGIN 'oso', '2121'




EXEC UDP_USUARIOS_INSERT 'Maria','Gomez','mar','123',1,1
EXEC UDP_USUARIOS_INSERT 'Angie','Campos','AgC','321',0,1

EXEC UDP_USUARIOS_INSERT 'Sarahi','Inestroza','Sara','JJJ',1,1
EXEC UDP_USUARIOS_INSERT 'Jason','Rivera','Json','Qwe11',0,1

EXEC UDP_USUARIOS_INSERT 'Esdra','Alvarez','Esdrinha','123',1,1
EXEC UDP_USUARIOS_INSERT 'Alberth','Castillo','AVG','XXX',0,1


GO






 CREATE OR ALTER PROCEDURE UDP_ELIMINAR
 @usu_Id		INT
 AS
 BEGIN
 DECLARE @usu_Estado BIT = 0;

 UPDATE [dbo].[tbUsuarios] SET [usu_Estado] = @usu_Estado WHERE [usu_Id]= @usu_Id

 END

 GO


 






