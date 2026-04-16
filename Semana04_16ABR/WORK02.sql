/*
Crear los siguientes esquemas, tablas y sus respectivas restricciones.
- MAESTROS
  - Tabla: PRODUCTO
- VENTAS
  - Tabla: VENTA
- COMPRAS
  - Tabla: COMPRAS
*/

show user;

-- Esquema: MAESTROS
-- =======================

-- Usuario
CREATE USER "MAESTROS" IDENTIFIED BY "maestros"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER "MAESTROS" QUOTA UNLIMITED ON "USERS";

-- ROLES
GRANT CONNECT, RESOURCE TO MAESTROS ;


-- Esquema: VENTAS
-- =======================

-- Usuario
CREATE USER "VENTAS" IDENTIFIED BY "ventas"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER "VENTAS" QUOTA UNLIMITED ON "USERS";

-- ROLES
GRANT CONNECT, RESOURCE TO VENTAS ;


-- Esquema: COMPRAS
-- =======================

-- Usuario
CREATE USER "COMPRAS" IDENTIFIED BY "compras"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER COMPRAS QUOTA UNLIMITED ON "USERS";

-- ROLES
GRANT CONNECT, RESOURCE TO COMPRAS ;

-- Tabla: PRODUCTO

create table MAESTROS.PRODUCTO(
  id_producto numeric(10,0) not null,
  nombre varchar2(100) not null,
  precio_costo numeric(10,2) not null,
  precio_venta numeric(10,2) not null,
  stock numeric(10,0) default 0 not null ,
  constraint producto_precio_costo check( precio_costo >= 0.0),
  constraint producto_precio_venta check( precio_venta >= precio_costo),
  constraint producto_stock check( stock >= 0.0),
  constraint pk_producto primary key(id_producto)
);


-- Tabla: VENTA

create table VENTAS.VENTA(
  id_venta numeric(10,0) not null,
  cliente varchar2(100) not null,
  id_producto numeric(10,0) not null,
  precio numeric(10,2) not null,
  cantidad numeric(10,0) not null,
  importe numeric(10,2) not null,
  constraint pk_venta primary key(id_venta),
  constraint venta_precio check( precio >= 0.0),
  constraint venta_cantidad check( cantidad >= 0.0)
);

GRANT REFERENCES ON MAESTROS.PRODUCTO TO VENTAS;

alter table VENTAS.VENTA
add constraint fk_venta_producto
foreign key (id_producto) references maestros.producto;


-- Probar

insert into maestros.producto values
(1,'Televisor',2460.00,4679.99,100);
insert into maestros.producto values
(2,'Laptop Lenovo',2600.00,3400.00,50);
insert into maestros.producto values
(3,'Mouse Logitec',300.00,400.00,130);

commit;

select * from maestros.producto;


-- Datos en la tabla: venta

insert into ventas.venta values
(1,'Juan Perez', 1, 100, 20, 50);
insert into ventas.venta values
(2,'Rafael Olivos', 3, 200, 10, 80);
insert into ventas.venta values
(3,'Henry Medina', 1, 100, 15, 50);

commit;

select * from ventas.venta;


SELECT 
    segment_name, 
    segment_type, 
    tablespace_name, 
    bytes / 1024 / 1024 AS tamanio_mb
FROM user_segments
ORDER BY tamanio_mb DESC;