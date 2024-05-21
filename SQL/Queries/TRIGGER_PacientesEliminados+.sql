CREATE TRIGGER PacientesEliminados ON Paciente
FOR DELETE
AS

IF EXISTS (SELECT idpaciente FROM PacienteLog
			WHERE idpaciente = (SELECT idpaciente FROM Deleted))
	UPDATE PacienteLog SET fechaBaja = GETDATE()
		WHERE idpaciente = (SELECT idpaciente FROM Deleted)
ELSE
	INSERT INTO PacienteLog (idpaciente, idpais, fechaBaja)
	SELECT idPaciente, idPais, GETDATE() FROM Deleted

