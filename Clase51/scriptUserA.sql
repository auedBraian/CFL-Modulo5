create database usuarios_seguridad;
use usuarios_seguridad;

create table Usuario(
nro_u    INTEGER        NOT NULL,
nombre   VARCHAR(45)    NOT NULL,
tarea    VARCHAR(45)    NOT NULL);

GRANT INSERT ON usuarios_seguridad.usuario TO C WITH GRANT OPTION;
GRANT SELECT ON usuarios_seguridad.usuario TO C WITH GRANT OPTION;
GRANT SELECT ON usuarios_seguridad.usuario TO D;
flush privileges;
REVOKE ALL ON usuarios_seguridad.* TO ‘B’@‘%’;



-- contraseñas A: Jack4517 ; B:Jack4518 ; C:Jack4519