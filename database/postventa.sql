create DATABASE postventa;
USE postventa;
create table roles(
    id_role int(11) not null primary key,
    nom_role varchar(50)
);
create table asesor(
    id_asesor int(11) not null primary key,
    nom_as varchar(50),
    apellido_as varchar(50)
);
create table servicio(
    id_servicio int(11) not null primary key,
    nom_serv varchar(50)
);
create table usuario(
    id_usuario int(11) not null primary key,
    email VARCHAR(50) not null,
    password VARCHAR(50) not null,
    id_role INT(11),
    FOREIGN KEY(id_role) REFERENCES roles(id_role)
);
CREATE TABLE venta(
    id_venta int(11) not null PRIMARY KEY,
    id_usuario INT(11),
    id_servicio INT(11),
    calificacion INT(1),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);
CREATE TABLE asesor_venta(
    id_asesor INT(11),
    id_venta INT(11),
    FOREIGN KEY (id_asesor) REFERENCES asesor(id_asesor),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);
-- poblar Roles
INSERT INTO roles
VALUES (1, 'cliente');
INSERT INTO roles
VALUES (2, 'jefe');
-- consultar roles
select *
from roles;
-- Poblar Servicios
INSERT INTO servicio
VALUES (1, 'Creditos hipotecarios');
INSERT INTO servicio
VALUES (2, 'Credito worflow');
INSERT INTO servicio
VALUES (3, 'Credito de consumo');
INSERT INTO servicio
VALUES (4, 'Credito web');
INSERT INTO servicio
VALUES (5, 'Atencion al cliente');
INSERT INTO servicio
VALUES (6, 'Atencion al cliente matriz ');
-- consultar servicios
select *
from servicio;
-- Poblar asesor
INSERT INTO asesor
values (1, 'juan', 'perez');
INSERT INTO asesor
values (2, 'carmen', 'alarcon');
INSERT INTO asesor
values (3, 'pepito', 'florez');
-- consultar asesores
select *
from asesor;
--Poblar usuario
INSERT INTO usuario
values (1, 'pedro@test.com', 'pedro123', 1);
INSERT INTO usuario
values (2, 'consuelo@test.com', 'consuelo123', 2);
INSERT INTO usuario
values (3, 'eric@test.com', 'eric123', 1);
-- consultar usuarios 
select *
from usuario;
--Poblar venta 
INSERT INTO venta
values (1, 1, 4, 5);
INSERT INTO venta
values (2, 3, 2, 2);
INSERT INTO venta
values (3, 1, 4, 4);
INSERT INTO venta
values (4, 3, 2, 3);
INSERT INTO venta
values (5, 1, 1, 2);
INSERT INTO venta
values (6, 3, 5, 5);
INSERT INTO venta
values (7, 1, 6, 0);
-- consultar ventas 
select *
from venta;
-- poblar asesor_venta
INSERT INTO asesor_venta
values(3, 1);
INSERT INTO asesor_venta
values(2, 1);
INSERT INTO asesor_venta
values(2, 2);
INSERT INTO asesor_venta
values(1, 2);
INSERT INTO asesor_venta
values(1, 3);
INSERT INTO asesor_venta
values(2, 4);
INSERT INTO asesor_venta
values(3, 4);
INSERT INTO asesor_venta
values(2, 5);
INSERT INTO asesor_venta
values(1, 6);
INSERT INTO asesor_venta
values(3, 6);
-- consultar asesor_venta   
select *
from asesor_venta;
-- consulta : Consultar el promedio de calificaciones agrupadas por servicio
select s.nom_serv,
    avg(v.calificacion) as calif_prom
from venta as v,
    servicio as s
WHERE v.id_servicio = s.id_servicio
group BY nom_serv;
-- consulta : Consultar el promedio de calificaciones agrupadas por asesores de servicios
select a.nom_as,
    avg(v.calificacion)
from venta as v,
    asesor_venta as av,
    asesor as a,
    servicio as s
WHERE v.id_venta = av.id_venta
    and a.id_asesor = av.id_asesor
    and s.id_servicio = v.id_servicio
group by nom_as;
-- trigger: Crear un trigger que inserte un registro en una tabla de avisos, cuando un usuario califica cualquier servicio con 0 o 1
create table avisos(
    id_aviso INT(11) not null primary key auto_increment,
    descripcion VARCHAR(50)
);

-- trigger 

DELIMITER $$
CREATE TRIGGER before_insert_venta
before INSERT ON venta FOR EACH ROW 
BEGIN 
IF NEW.calificacion <= 1 THEN
INSERT INTO avisos(descripcion)values (CONCAT('La venta: ',NEW.id_venta,' tiene una calificacion de: ',NEW.calificacion));
END IF;
END;$$

-- pruebas TRIGGER
INSERT INTO venta
values (7, 1, 6, 0);
INSERT INTO venta
values (8, 3, 2, 1);
INSERT INTO venta
values (9, 3, 2, 5);

select * from venta;