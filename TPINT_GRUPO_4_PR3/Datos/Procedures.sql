USE ClinicaDB;
GO

CREATE OR ALTER PROCEDURE sp_AltaPaciente
    @DNI VARCHAR(25),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Nacionalidad VARCHAR(50),                                -- Agregar Paciente
    @FechaNacimiento DATE,
    @Sexo INT,
    @IdLocalidad INT,
    @ObraSocial INT,
    @UltimaAtencion DATETIME,
    @Alta DATETIME,
	@Direccion varchar(50),
	@Telefono VARCHAR(25),
	@Correo VARCHAR(50)
	
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;  

        IF EXISTS (SELECT 1 FROM Persona WHERE DNI = @DNI)
        BEGIN
            RAISERROR('Ya existe una persona con ese DNI.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Persona (DNI, nombre, apellido, sexo, direccion, idLocalidad, fechaNacimiento, nacionalidad)
        VALUES (@DNI, @Nombre, @Apellido, @Sexo, @Direccion,@IdLocalidad, @FechaNacimiento, @Nacionalidad);

        INSERT INTO Paciente (DNI, ObraSocial, ultimaAtencion, alta)
        VALUES (@DNI, @ObraSocial, @UltimaAtencion, @Alta);

		INSERT INTO Telefonos(idPersona,telefono)
		VALUES (@DNI, @telefono)

		INSERT INTO Correos(idPersona, correo)
		VALUES (@DNI, @Correo)

        COMMIT TRANSACTION;
        PRINT 'Paciente agregado exitosamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

GO

CREATE OR ALTER PROCEDURE sp_EliminarPaciente     --  Eliminar Paciente
    @DNI VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

   
        IF NOT EXISTS (SELECT 1 FROM Paciente WHERE DNI = @DNI)
        BEGIN
            RAISERROR('No existe ning�n paciente con ese DNI.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

      
UPDATE Persona 
SET activo = 0
WHERE DNI = @DNI;

        COMMIT TRANSACTION;
        PRINT 'Paciente eliminado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

GO

CREATE OR ALTER PROCEDURE sp_ModificarPaciente  -- Modificar Paciente
    @DNI VARCHAR(50),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Nacionalidad VARCHAR(50),
    @FechaNacimiento DATE,
    @Sexo INT,
    @IdLocalidad INT,	
    @Direccion VARCHAR(50),
    @ObraSocial INT,
    @Correo VARCHAR(50),
    @Telefono VARCHAR(25)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

    
        IF NOT EXISTS (SELECT 1 FROM Persona WHERE DNI = @DNI)
        BEGIN
            RAISERROR('No existe una persona con ese DNI.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

 
        IF NOT EXISTS (SELECT 1 FROM Paciente WHERE DNI = @DNI)
        BEGIN
            RAISERROR('La persona no est� registrada como paciente.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

     
        UPDATE Persona
        SET nombre = @Nombre,
            apellido = @Apellido,
            sexo = @Sexo,
            direccion = @Direccion,
            idLocalidad = @IdLocalidad,
            fechaNacimiento = @FechaNacimiento,
            nacionalidad = @Nacionalidad
        WHERE DNI = @DNI;

      
        UPDATE Paciente
        SET ObraSocial = @ObraSocial
        WHERE DNI = @DNI;

    
        UPDATE Correos
        SET correo = @Correo
        WHERE idPersona = @DNI;

       
        UPDATE Telefonos
        SET telefono = @Telefono
        WHERE idPersona = @DNI;

        COMMIT TRANSACTION;
        PRINT 'Paciente modificado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

GO
CREATE OR ALTER PROCEDURE sp_AltaMedico -- Agregar Medico
    @Legajo VARCHAR(50),
	@DNI VARCHAR(50),
	@idEspecialidad INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Nacionalidad VARCHAR(50),
    @FechaNacimiento DATE,
    @Sexo INT,
    @IdLocalidad INT,
	@Telefono VARCHAR(50),
	@Direccion VARCHAR(50),
	@Correo VARCHAR(50)
	
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM Persona WHERE DNI = @DNI)
        BEGIN
            RAISERROR('Ya existe un medico con ese DNI.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO Persona (DNI, nombre, apellido, sexo, direccion, idLocalidad, fechaNacimiento, nacionalidad)
        VALUES (@DNI, @Nombre, @Apellido, @Sexo, @Direccion,@IdLocalidad, @FechaNacimiento, @Nacionalidad);

        INSERT INTO Medico(DNI, Legajo, idEspecialidad)
        VALUES (@DNI, @Legajo, @idEspecialidad);

		INSERT INTO Telefonos(idPersona,telefono)
		VALUES (@DNI, @telefono)

		INSERT INTO Correos(idPersona, correo)
		VALUES (@DNI, @Correo)

        COMMIT TRANSACTION;
        PRINT 'M�dico agregado exitosamente.';
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;

    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@ErrorMessage, 16, 1); 
END CATCH
END;

GO

CREATE OR ALTER PROCEDURE sp_EliminarMedico  --  Eliminar Medico
    @DNI INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

   
        IF NOT EXISTS (SELECT 1 FROM Medico WHERE DNI = @DNI)
        BEGIN
            RAISERROR('No existe ning�n m�dico con ese DNI.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

      

      
UPDATE Persona 
SET activo = 0
WHERE DNI = @DNI;

        COMMIT TRANSACTION;
        PRINT 'M�dico eliminado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

GO

CREATE OR ALTER PROCEDURE sp_ModificarMedico --  Modificar Medico
	@Legajo VARCHAR(50),
	@DNI VARCHAR(50),
	@idEspecialidad INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Nacionalidad VARCHAR(50),
    @FechaNacimiento DATE,
    @Sexo INT,
    @IdLocalidad INT,
	@Telefono VARCHAR(25),
	@Direccion VARCHAR(50),
	@Correo VARCHAR(50)

AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

    
        PRINT 'Antes de IF1';
        IF NOT EXISTS (SELECT 1 FROM Persona WHERE DNI = @DNI)
        BEGIN
            RAISERROR('No existe una persona con ese DNI.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

 
        PRINT 'Antes de IF2';
        IF NOT EXISTS (SELECT 1 FROM Medico WHERE DNI = @DNI)
        BEGIN
            RAISERROR('La persona no est� registrada como m�dico.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

     
        PRINT 'Antes de Carga';
        UPDATE Persona
			
        SET DNI = @DNI,
			nombre = @Nombre,
            apellido = @Apellido,
            sexo = @Sexo,
            direccion = @Direccion,
            idLocalidad = @IdLocalidad,
            fechaNacimiento = @FechaNacimiento,
            nacionalidad = @Nacionalidad
        WHERE DNI = @DNI;

      
        UPDATE Medico
        SET idEspecialidad = @idEspecialidad,
		Legajo = @Legajo
        WHERE DNI = @DNI;

    
        UPDATE Correos
        SET correo = @Correo
        WHERE idPersona = @DNI;

       
        UPDATE Telefonos
        SET telefono = @Telefono
        WHERE idPersona = @DNI;
		
        PRINT 'Despues de Carga';
        COMMIT TRANSACTION;
        PRINT 'M�dico modificado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

SELECT * FROM Persona

