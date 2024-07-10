

CREATE TABLE [dbo].[Pago](
	[idpago] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[concepto] [tinyint] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[monto] [money] NOT NULL,
	[estado] [tinyint] NULL,
	[obs] [varchar](1000) NULL
)
GO


