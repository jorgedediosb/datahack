
CREATE TABLE [dbo].[PagoPaciente](
	[idpago] [int] NOT NULL,
	[idpaciente] [int] NOT NULL,
	[idturno] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idpago] ASC,
	[idpaciente] ASC,
	[idturno] ASC
))
GO

