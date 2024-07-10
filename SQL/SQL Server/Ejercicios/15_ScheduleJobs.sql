/*
Los Schedule Jobs en SQL Server son tareas automatizadas que se configuran y gestionan mediante SQL Server Agent.
SQL Server Agent es un servicio que ejecuta trabajos programados y puede realizar una variedad de tareas,
como ejecutar scripts SQL, respaldar bases de datos, enviar correos electrónicos y más.
Los jobs programados ayudan a automatizar tareas administrativas y de mantenimiento, mejorando la eficiencia
y reduciendo la necesidad de intervención manual.

Componentes de un Schedule Job:
1. Job: Una tarea que se programa para ejecutarse a intervalos específicos.
2. Steps: Los pasos individuales que componen un job. Cada paso puede ser una tarea como ejecutar una consulta SQL, ejecutar un paquete SSIS, etc.
3. Schedules: Define cuándo y con qué frecuencia se ejecuta el job.
4. Alerts: Notificaciones configuradas para eventos específicos.
5. Operators: Usuarios o grupos de usuarios que reciben notificaciones sobre la ejecución de los jobs.
*/


--Crear un Schedule Job para Respaldar una Base de Datos Diariamente:

--Crear un Nuevo Job:
USE msdb;
GO
EXEC dbo.sp_add_job
    @job_name = N'RespaldoDiario';

--Agregar un Paso al Job:
EXEC dbo.sp_add_jobstep
    @job_name = N'RespaldoDiario',
    @step_name = N'RespaldoCompleto',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE NombreDeTuBaseDeDatos
                 TO DISK = ''C:\RutaDelArchivoDeRespaldo\NombreDeTuBaseDeDatos_Full.bak''
                 WITH FORMAT, MEDIANAME = ''SQLServerBackups'', NAME = ''Full Backup of NombreDeTuBaseDeDatos'';',
    @retry_attempts = 1,
    @retry_interval = 5;

--Crear un Horario (Schedule) para el Job:
EXEC dbo.sp_add_schedule
    @schedule_name = N'HorarioDiario',
    @freq_type = 4,  -- Diario
    @freq_interval = 1,
    @active_start_time = 233000;  -- 23:30 (11:30 PM)

--Asignar el Horario al Job:
EXEC dbo.sp_attach_schedule
    @job_name = N'RespaldoDiario',
    @schedule_name = N'HorarioDiario';

--Iniciar el Job:
EXEC dbo.sp_start_job
    @job_name = N'RespaldoDiario';

/*
Resumen:
Los jobs programados en SQL Server son una herramienta poderosa para automatizar tareas administrativas
y de mantenimiento en la base de datos. Mediante el uso de SQL Server Agent, puedes crear, programar
y gestionar jobs que ejecuten comandos T-SQL, paquetes SSIS, y más. Los ejemplos anteriores muestran
cómo crear jobs para realizar respaldos, reindexar tablas y limpiar datos obsoletos,
demostrando la flexibilidad y utilidad de los jobs programados en SQL Server.
*/