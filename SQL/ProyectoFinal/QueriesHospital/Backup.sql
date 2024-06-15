


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