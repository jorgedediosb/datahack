/*
Realizar un respaldo (backup) de una base de datos es una tarea crítica para asegurar la disponibilidad
y recuperación de datos en caso de pérdida o corrupción. En SQL Server,
puedes usar el comando BACKUP DATABASE para crear un respaldo de la base de datos.
*/

BACKUP DATABASE NombreDeTuBaseDeDatos
TO DISK = 'C:\RutaDelArchivoDeRespaldo\NombreDeTuBaseDeDatos.bak'
WITH FORMAT, -- Se puede indicar 'WITH NO_COMPRESSION' si no se quiere compresión.
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Full Backup of NombreDeTuBaseDeDatos';


--Respaldo Diferencial: Solo se respaldan los datos que han cambiado desde el último respaldo completo.
BACKUP DATABASE NombreDeTuBaseDeDatos
TO DISK = 'C:\RutaDelArchivoDeRespaldo\NombreDeTuBaseDeDatos_Diff.bak'
WITH DIFFERENTIAL,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Differential Backup of NombreDeTuBaseDeDatos';


--Respaldo de Registro de Transacciones (Transaction Log): Respalda el registro de transacciones,
--útil para restaurar la base de datos a un punto en el tiempo específico.
BACKUP LOG NombreDeTuBaseDeDatos
TO DISK = 'C:\RutaDelArchivoDeRespaldo\NombreDeTuBaseDeDatos_Log.trn'
WITH MEDIANAME = 'SQLServerBackups',
     NAME = 'Transaction Log Backup of NombreDeTuBaseDeDatos';


--Script con Respaldo Completo y Diferencial
-- Respaldo Completo
BACKUP DATABASE NombreDeTuBaseDeDatos
TO DISK = 'C:\RutaDelArchivoDeRespaldo\NombreDeTuBaseDeDatos_Full.bak'
WITH FORMAT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Full Backup of NombreDeTuBaseDeDatos';

-- Respaldo Diferencial (se puede ejecutar en otro momento)
BACKUP DATABASE NombreDeTuBaseDeDatos
TO DISK = 'C:\RutaDelArchivoDeRespaldo\NombreDeTuBaseDeDatos_Diff.bak'
WITH DIFFERENTIAL,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Differential Backup of NombreDeTuBaseDeDatos';

-- Respaldo del Registro de Transacciones (se puede ejecutar periódicamente)
BACKUP LOG NombreDeTuBaseDeDatos
TO DISK = 'C:\RutaDelArchivoDeRespaldo\NombreDeTuBaseDeDatos_Log.trn'
WITH MEDIANAME = 'SQLServerBackups',
     NAME = 'Transaction Log Backup of NombreDeTuBaseDeDatos';


--Ejemplo Script para guardar un Backup de la base de datos del proyecto 'Hospital'
declare @fecha char(12)
declare @path varchar(100)
declare @name varchar(20)

--print convert(char(5),getdate(),108)
set @fecha = convert(char(8),getdate(),112) + replace(convert(char(5),getdate(),108),':','')
set @path = 'C:\backup_SQL\CentroMedico'+@fecha+'.bak'
set @name = 'CentroMedico'+@fecha

BACKUP DATABASE CentroMedico
TO DISK = @path
WITH NO_COMPRESSION, NAME=@name