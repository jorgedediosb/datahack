


--select * from view_medicosEspecialidades


CREATE VIEW VIEW_MedicosEspecialidades AS

select M.idmedico,M.nombre,M.apellido,ME.idEspecialidad,Me.descripcion from Medico M
inner join MedicoEspecialidad ME
on ME.idmedico = M.idMedico