
CREATE TABLE [dbo].[Turno](
	[idTurno] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fechaTurno] [datetime] NULL,
	[estado] [smallint] NULL,
	[observacion] [varchar] (30)
 )
GO


