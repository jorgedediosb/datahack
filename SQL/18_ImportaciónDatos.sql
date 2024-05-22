/*
Importar datos desde una tabla de Excel a una base de datos SQL Server puede hacerse de varias maneras.
- Utilizando SQL Server Management Studio (SSMS) y el Asistente de Importación y Exportación
- Utilizando la funcionalidad de OPENROWSET
- Utilizando SSIS (SQL Server Integration Services)
*/

--Utilizando OPENROWSET:
    --Habilitar Ad Hoc Distributed Queries:
    EXEC sp_configure 'show advanced options', 1;
    RECONFIGURE;
    EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
    RECONFIGURE;

    -- Asegúrate de que el proveedor ACE OLEDB esté instalado en tu servidor SQL.
    -- Puedes descargarlo desde https://www.microsoft.com/en-us/download/details.aspx?id=54920
    -- Importar datos desde una hoja de cálculo específica
    SELECT *
    INTO NombreDeTuTablaDeDestino
    FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 
                    'Excel 12.0;Database=C:\Ruta\A\TuArchivo.xlsx', 
                    'SELECT * FROM [NombreDeLaHoja$]');
