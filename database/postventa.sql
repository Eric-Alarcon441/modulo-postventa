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
  id_asesor int(11),
  calificacion INT(1),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio),
  FOREIGN KEY (id_asesor) REFERENCES asesor(id_asesor)
);
-- poblar Roles
INSERT INTO
  roles
VALUES
  (1, 'cliente');
INSERT INTO
  roles
VALUES
  (2, 'jefe');
-- consultar roles
select
  *
from
  roles;
-- Poblar Servicios
INSERT INTO
  servicio
VALUES
  (1, 'Creditos hipotecarios');
INSERT INTO
  servicio
VALUES
  (2, 'Credito worflow');
INSERT INTO
  servicio
VALUES
  (3, 'Credito de consumo');
INSERT INTO
  servicio
VALUES
  (4, 'Credito web');
INSERT INTO
  servicio
VALUES
  (5, 'Atencion al cliente');
INSERT INTO
  servicio
VALUES
  (6, 'Atencion al cliente matriz ');
-- consultar servicios
select
  *
from
  servicio;
-- Poblar asesor
INSERT INTO
  asesor
values
  (1, 'juan', 'perez');
INSERT INTO
  asesor
values
  (2, 'carmen', 'alarcon');
INSERT INTO
  asesor
values
  (3, 'pepito', 'florez');
-- consultar asesores
select
  *
from
  asesor;
--Poblar usuario
INSERT INTO
  usuario
values
  (1, 'pedro@test.com', 'pedro123', 1);
INSERT INTO
  usuario
values
  (2, 'consuelo@test.com', 'consuelo123', 2);
INSERT INTO
  usuario
values
  (3, 'eric@test.com', 'eric123', 1);
-- consultar usuarios
select
  *
from
  usuario;
--Poblar venta
INSERT INTO
  venta
VALUES
  (null, 1, 4, 2, 3);
INSERT INTO
  venta
VALUES
  (null, 3, 2, 3, 5);
INSERT INTO
  venta
VALUES
  (null, 1, 2, 1, 3);
INSERT INTO
  venta
VALUES
  (null, 3, 3, 1, 4);
-- consultar ventas
select
  *
from
  venta;
-- consulta : Consultar el promedio de calificaciones agrupadas por servicio
select
  s.nom_serv,
  avg(v.calificacion) as calif_prom
from
  venta as v,
  servicio as s
WHERE
  v.id_servicio = s.id_servicio
group BY
  nom_serv;
-- consulta : Consultar el promedio de calificaciones agrupadas por asesores de servicios
select
  a.nom_as,
  avg(v.calificacion)
from
  venta as v,
  asesor as a,
  servicio as s
WHERE
  a.id_asesor = v.id_asesor
  and s.id_servicio = v.id_servicio
group by
  nom_as;
-- trigger: Crear un trigger que inserte un registro en una tabla de avisos, cuando un usuario califica cualquier servicio con 0 o 1
  create table avisos(
    id_aviso INT(11) not null primary key auto_increment,
    descripcion VARCHAR(50)
  );
-- trigger
  DELIMITER $ $ CREATE TRIGGER mala_calificacion before
INSERT
  ON venta FOR EACH ROW BEGIN IF NEW.calificacion <= 1 THEN
INSERT INTO
  avisos(descripcion)
values
  (
    CONCAT(
      'El usuario ',
      NEW.id_usuario,
      ' califico con: ',
      NEW.calificacion,
      ' el servicio: ',
      NEW.id_servicio
    )
  );
END IF;
END;
$ $ -- pruebas TRIGGER
INSERT INTO
  venta
VALUES
  (null, 3, 5, 3, 1);