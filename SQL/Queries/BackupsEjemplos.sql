--Backup de solo copia
BACKUP DATABASE Northwind TO  DISK = 'C:\Data\BackupNorthwind.bak' 
WITH  COPY_ONLY,  Name='Backup de solo Copia',
DESCRIPTION = 'Backup de solo copia de la base de datos Northwind'
GO
--Backup de un Filegroup
BACKUP DATABASE Northwind FILEGROUP = 'PRIMARY'
 TO  DISK = 'C:\Data\BackupNorthwind.bak' 
 WITH  NAME = 'Northwind-Full Database Backup'
--Consultar los archivos de la BD
SP_HELPDB Northwind
--Backup de un Filegroup
BACKUP DATABASE Northwind FILE = 'Northwind'
 TO  DISK = 'C:\Data\BackupNorthwind.bak' 
 WITH  NAME = 'Northwind-Full Database Backup'
 /*
 Opciones de WITH
DIFFERENTIAL
Se aplica a: SQL Server Se usa solo con BACKUP DATABASE. Especifica que la copia de seguridad de la base de datos o el archivo solo debe estar compuesta por las partes de la base de datos o el archivo que hayan cambiado desde la última copia de seguridad completa. Una copia de seguridad diferencial suele ocupar menos espacio que una copia de seguridad completa. Utilice esta opción para que no tenga que aplicar todas las copias de seguridad del registro individuales efectuadas desde que se realizó la última copia de seguridad completa.
ENCRYPTION
Se utiliza para especificar el cifrado para una copia de seguridad. Puede especificar un algoritmo de cifrado para cifrar la copia de seguridad o especificar NO_ENCRYPTION para no hacer que la copia de seguridad se cifre. El cifrado es una práctica recomendada para ayudar a proteger los archivos de copia de seguridad 
COPY_ONLY Se aplica a: SQL Server e Instancia administrada de SQL Database Especifica que la copia de seguridad es una copia de seguridad de solo copia, lo que no afecta a la secuencia normal de copias de seguridad. Se crea una copia de seguridad de solo copia independientemente de las copias de seguridad convencionales programadas regularmente. Una copia de seguridad de solo copia no afecta a los procedimientos de copias de seguridad y restauración generales de la base de datos.
COMPRESSION
Habilita de forma explícita la compresión de copia de seguridad.

NO_COMPRESSION
Deshabilita de forma explícita la compresión de copia de seguridad.

DESCRIPTION = { 'texto' | @variable_de_texto }
Especifica el texto de forma libre que describe el conjunto de copia de seguridad. La cadena puede tener un máximo de 255 caracteres.

NAME = { backup_set_name | @backup_set_var }
Especifica el nombre del conjunto de copia de seguridad. Los nombres pueden tener un máximo de 128 caracteres. Si no se especifica NAME, está en blanco.

{ EXPIREDATE ='date' | RETAINDAYS = days }
Especifica cuándo se puede sobrescribir el conjunto de copia de seguridad para esta copia de seguridad. Si se usan las dos opciones, RETAINDAYS tiene precedencia sobre EXPIREDATE.
RETAINDAYS = { days | @days_var } Especifica el número de días que deben transcurrir antes de que se pueda sobrescribir este conjunto de medios de copia de seguridad. Si se proporciona como una variable (@days_var), se debe especificar como un entero.
NOINIT
Indica que el conjunto de copia de seguridad se anexa al conjunto de medios especificado, conservando así los conjuntos de copia de seguridad existentes. Si se ha definido una contraseña para el conjunto de medios, debe proporcionarla. NOINIT es el valor predeterminado.

Para obtener más información, vea Conjuntos de medios, familias de medios y conjuntos de copias de seguridad (SQL Server).

INIT
Especifica que se deben sobrescribir todos los conjuntos de copia de seguridad, pero conserva el encabezado de medios. Si se especifica INIT, se sobrescriben todos los conjuntos de copia de seguridad existentes en el dispositivo, si las condiciones lo permiten. 
NOSKIP
Indica a la instrucción BACKUP que compruebe la fecha de expiración de todos los conjuntos de copia de seguridad de los medios antes de permitir que se sobrescriban. Éste es el comportamiento predeterminado.

SKIP
Deshabilita la comprobación de la expiración y el nombre del conjunto de copia de seguridad que suele realizar la instrucción BACKUP para impedir que se sobrescriban los conjuntos de copia de seguridad. Para obtener más información acerca de las interacciones entre { INIT | NOINIT } y { NOSKIP | SKIP }, vea "Comentarios", más adelante en este tema.
NOFORMAT
Especifica que la operación de copia de seguridad conservará los conjuntos de copias de seguridad y el encabezado de medios existentes en los volúmenes de medios usados en esta operación de copia de seguridad. Éste es el comportamiento predeterminado.

FORMAT
Especifica que se debe crear un conjunto de medios nuevo. FORMAT hace que la operación de copia de seguridad escriba un nuevo encabezado de medios en todos los volúmenes de medios usados en la operación de copia de seguridad. El contenido existente del volumen no será válido porque se sobrescribirán los conjuntos de copias de seguridad y el encabezado de medios existentes.


 */
-----Ejercicio de estrategia de Backups----------------------
use Northwind
go
---Backup Completo
Backup database Northwind
to disk='C:\Data\BackupNorthwind.bak'
with name='BackupCompleto'

--Insertar datos
Insert into customers (customerid, companyname, contactname, country)
values
('ABCD0','Visoal','Victor Cardenas','Guatemala'),
('ABCD1','Hernandez','Claudia Hernandez','Guatemala')
--Backup del Log
Backup log Northwind
to disk='C:\Data\BackupNorthwind.bak'
with name='BackupLog1'
--Insertar datos
Insert into customers (customerid, companyname, contactname, country)
values
('ABCD2','OtroMas','Victor Cardenas','Guatemala'),
('ABCD3','OtroMas2','Claudia Herandez','Guatemala')

---Backup Diferencial
Backup database Northwind
to disk='C:\Data\BackupNorthwind.bak'
with name='BackupDiferencial', differential
--Insertar Datos
Insert into customers (customerid, companyname, contactname, country)
values
('ABCD4','UltimaEmpresa','Victor Cardenas','Guatemala'),
('ABCD5','Empresa2Ya','Claudia Herandez','Guatemala')
--Backup del Log
Backup log Northwind
to disk='C:\Data\BackupNorthwind.bak'
with name='BackupLog2'
----Informacion de los backups dentro del archivo .bak
Restore headeronly 
from disk='C:\Data\BackupNorthwind.bak'
use master
drop database Northwind
----------------Restore de backup completo y los del log
Restore database northwind from disk='C:\Data\BackupNorthwind.bak'
with file=1, norecovery

Restore log northwind from disk='C:\Data\BackupNorthwind.bak'
with file=2, norecovery

Restore log northwind from disk='C:\Data\BackupNorthwind.bak'
with file=4, recovery

use northwind
go
Select * from Customers

----------------Restore de backup completo y diferencial
Restore database northwind from disk='C:\Data\BackupNorthwind.bak'
with file=1, norecovery

Restore database northwind from disk='C:\Data\BackupNorthwind.bak'
with file=3, recovery



