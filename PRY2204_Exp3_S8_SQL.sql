-- ============================================================
-- PRY2204 - Modelamiento de Bases de Datos
-- Experiencia 3 - Semana 8
-- Taller Mecánico Mikes Ltda.
-- Construcción, poblamiento y recuperación de datos
-- Oracle Database / SQL Developer
-- ============================================================


-- ============================================================
-- 0. LIMPIEZA SEGURA
-- Permite volver a ejecutar el script completo sin dejar objetos
-- duplicados de una ejecución anterior.
-- ============================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DETALLE_SERVICIO CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE MANTENCION CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE AUTOMOVIL CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ESTANDAR CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PREMIUM CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CLIENTE CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE MODELO CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TIPO_AUTOMOVIL CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE MARCA CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SERVICIO CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE MECANICO CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SUCURSAL CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CIUDAD CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PAIS CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_SERVICIO';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_CIUDAD';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/


-- ============================================================
-- CASO 1: IMPLEMENTACIÓN DEL MODELO RELACIONAL
-- ============================================================

CREATE TABLE PAIS (
    id_pais NUMBER(3)
        GENERATED ALWAYS AS IDENTITY
        (START WITH 9 INCREMENT BY 3),
    nom_pais VARCHAR2(30) NOT NULL
);

CREATE TABLE CIUDAD (
    id_ciudad  NUMBER(3) NOT NULL,
    nom_ciudad VARCHAR2(30) NOT NULL,
    cod_pais   NUMBER(3) NOT NULL
);

CREATE TABLE SUCURSAL (
    id_sucursal  CHAR(3) NOT NULL,
    nom_sucursal VARCHAR2(20) NOT NULL,
    calle        VARCHAR2(20) NOT NULL,
    num_calle    NUMBER(4) NOT NULL,
    cod_ciudad   NUMBER(3) NOT NULL
);

CREATE TABLE MECANICO (
    cod_mecanico NUMBER(5)
        GENERATED ALWAYS AS IDENTITY
        (START WITH 460 INCREMENT BY 7),
    pnombre         VARCHAR2(20) NOT NULL,
    snombre         VARCHAR2(20) NOT NULL,
    apaterno        VARCHAR2(20) NOT NULL,
    amaterno        VARCHAR2(20) NOT NULL,
    bono_jefatura   NUMBER(10),
    sueldo          NUMBER(10) NOT NULL,
    monto_impuestos NUMBER(10) NOT NULL,
    cod_supervisor  NUMBER(5)
);

CREATE TABLE SERVICIO (
    id_servicio NUMBER(3) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    costo       NUMBER(7) NOT NULL
);

CREATE TABLE MARCA (
    id_marca    NUMBER(2) NOT NULL,
    descripcion VARCHAR2(20) NOT NULL
);

CREATE TABLE TIPO_AUTOMOVIL (
    id_tipo     CHAR(3) NOT NULL,
    descripcion VARCHAR2(20) NOT NULL
);

CREATE TABLE MODELO (
    id_modelo   NUMBER(5) NOT NULL,
    marca_id    NUMBER(2) NOT NULL,
    descripcion VARCHAR2(20) NOT NULL
);

CREATE TABLE CLIENTE (
    rut      NUMBER(8) NOT NULL,
    dv       CHAR(1) NOT NULL,
    pnombre  VARCHAR2(20) NOT NULL,
    snombre  VARCHAR2(20) NOT NULL,
    apaterno VARCHAR2(20) NOT NULL,
    amaterno VARCHAR2(20) NOT NULL,
    telefono VARCHAR2(12) NOT NULL,
    email    VARCHAR2(40),
    tipo_cli CHAR(1) NOT NULL
);

CREATE TABLE ESTANDAR (
    cl_rut            NUMBER(8) NOT NULL,
    puntaje_fidelidad NUMBER(10) NOT NULL
);

CREATE TABLE PREMIUM (
    cl_rut        NUMBER(8) NOT NULL,
    pesos_clientes NUMBER(10) NOT NULL,
    monto_credito NUMBER(10) NOT NULL
);

CREATE TABLE AUTOMOVIL (
    patente       CHAR(8) NOT NULL,
    anio          NUMBER(4) NOT NULL,
    cant_puertas  NUMBER(1) NOT NULL,
    km            NUMBER(6) NOT NULL,
    color         VARCHAR2(30) NOT NULL,
    cod_tipo_auto CHAR(3) NOT NULL,
    cod_modelo    NUMBER(5) NOT NULL,
    cod_marca     NUMBER(2) NOT NULL,
    cl_rut        NUMBER(8) NOT NULL
);

CREATE TABLE MANTENCION (
    num_mantencion NUMBER(4) NOT NULL,
    cod_sucursal   CHAR(3) NOT NULL,
    fecha_ingreso  DATE NOT NULL,
    fecha_salida   DATE,
    patente_auto   CHAR(8),
    cod_mecanico   NUMBER(5) NOT NULL,
    costo_total    NUMBER(7) NOT NULL,
    estado         VARCHAR2(15) NOT NULL
);

CREATE TABLE DETALLE_SERVICIO (
    mantencion_num NUMBER(4) NOT NULL,
    cod_servicio   NUMBER(3) NOT NULL,
    descuento_serv NUMBER(4,3) NOT NULL,
    cantidad       NUMBER(3) NOT NULL
);


-- ============================================================
-- PK
-- ============================================================

ALTER TABLE PAIS
    ADD CONSTRAINT PAIS_PK PRIMARY KEY (id_pais);

ALTER TABLE CIUDAD
    ADD CONSTRAINT CIUDAD_PK PRIMARY KEY (id_ciudad);

ALTER TABLE SUCURSAL
    ADD CONSTRAINT SUCURSAL_PK PRIMARY KEY (id_sucursal);

ALTER TABLE MECANICO
    ADD CONSTRAINT MECANICO_PK PRIMARY KEY (cod_mecanico);

ALTER TABLE SERVICIO
    ADD CONSTRAINT SERVICIO_PK PRIMARY KEY (id_servicio);

ALTER TABLE MARCA
    ADD CONSTRAINT MARCA_PK PRIMARY KEY (id_marca);

ALTER TABLE TIPO_AUTOMOVIL
    ADD CONSTRAINT TIPO_AUTOMOVIL_PK PRIMARY KEY (id_tipo);

ALTER TABLE MODELO
    ADD CONSTRAINT MODELO_PK PRIMARY KEY (id_modelo, marca_id);

ALTER TABLE CLIENTE
    ADD CONSTRAINT CLIENTE_PK PRIMARY KEY (rut);

ALTER TABLE ESTANDAR
    ADD CONSTRAINT ESTANDAR_PK PRIMARY KEY (cl_rut);

ALTER TABLE PREMIUM
    ADD CONSTRAINT PREMIUM_PK PRIMARY KEY (cl_rut);

-- PK inicial indicada por el modelo; se modifica en Caso 2.
ALTER TABLE MANTENCION
    ADD CONSTRAINT MANTENCION_PK PRIMARY KEY (num_mantencion);

ALTER TABLE AUTOMOVIL
    ADD CONSTRAINT AUTOMOVIL_PK PRIMARY KEY (patente);

ALTER TABLE DETALLE_SERVICIO
    ADD CONSTRAINT DETALLE_SERVICIO_PK
    PRIMARY KEY (mantencion_num, cod_servicio);


-- ============================================================
-- FK
-- ============================================================

ALTER TABLE CIUDAD
    ADD CONSTRAINT CIUDAD_FK_PAIS
    FOREIGN KEY (cod_pais)
    REFERENCES PAIS (id_pais);

ALTER TABLE SUCURSAL
    ADD CONSTRAINT SUCURSAL_FK_CIUDAD
    FOREIGN KEY (cod_ciudad)
    REFERENCES CIUDAD (id_ciudad);

ALTER TABLE MECANICO
    ADD CONSTRAINT MECANICO_FK_SUPERVISOR
    FOREIGN KEY (cod_supervisor)
    REFERENCES MECANICO (cod_mecanico);

ALTER TABLE MODELO
    ADD CONSTRAINT MODELO_FK_MARCA
    FOREIGN KEY (marca_id)
    REFERENCES MARCA (id_marca);

ALTER TABLE ESTANDAR
    ADD CONSTRAINT ESTANDAR_FK_CLIENTE
    FOREIGN KEY (cl_rut)
    REFERENCES CLIENTE (rut);

ALTER TABLE PREMIUM
    ADD CONSTRAINT PREMIUM_FK_CLIENTE
    FOREIGN KEY (cl_rut)
    REFERENCES CLIENTE (rut);

ALTER TABLE AUTOMOVIL
    ADD CONSTRAINT AUTOMOVIL_FK_CLIENTE
    FOREIGN KEY (cl_rut)
    REFERENCES CLIENTE (rut);

ALTER TABLE AUTOMOVIL
    ADD CONSTRAINT AUTOMOVIL_FK_MODELO
    FOREIGN KEY (cod_modelo, cod_marca)
    REFERENCES MODELO (id_modelo, marca_id);

ALTER TABLE AUTOMOVIL
    ADD CONSTRAINT AUTOMOVIL_FK_TIPO
    FOREIGN KEY (cod_tipo_auto)
    REFERENCES TIPO_AUTOMOVIL (id_tipo);

ALTER TABLE MANTENCION
    ADD CONSTRAINT MANTENCION_FK_SUCURSAL
    FOREIGN KEY (cod_sucursal)
    REFERENCES SUCURSAL (id_sucursal);

ALTER TABLE MANTENCION
    ADD CONSTRAINT MANTENCION_FK_AUTOMOVIL
    FOREIGN KEY (patente_auto)
    REFERENCES AUTOMOVIL (patente);

ALTER TABLE MANTENCION
    ADD CONSTRAINT MANTENCION_FK_MECANICO
    FOREIGN KEY (cod_mecanico)
    REFERENCES MECANICO (cod_mecanico);

ALTER TABLE DETALLE_SERVICIO
    ADD CONSTRAINT DET_SERV_FK_MANTENCION
    FOREIGN KEY (mantencion_num)
    REFERENCES MANTENCION (num_mantencion);

ALTER TABLE DETALLE_SERVICIO
    ADD CONSTRAINT DET_SERV_FK_SERVICIO
    FOREIGN KEY (cod_servicio)
    REFERENCES SERVICIO (id_servicio);


-- ============================================================
-- CASO 2: MODIFICACIÓN DEL MODELO CON ALTER TABLE
-- ============================================================

-- 1. Eliminar atributo derivado costo_total.
ALTER TABLE MANTENCION
    DROP COLUMN costo_total;

-- 2. La mantención pasa a identificarse por número + sucursal.
-- Primero se elimina la FK dependiente y luego se modifica la PK.
ALTER TABLE DETALLE_SERVICIO
    DROP CONSTRAINT DET_SERV_FK_MANTENCION;

ALTER TABLE DETALLE_SERVICIO
    DROP CONSTRAINT DETALLE_SERVICIO_PK;

ALTER TABLE MANTENCION
    DROP CONSTRAINT MANTENCION_PK;

-- Se incorpora la sucursal al detalle para conservar la identificación
-- completa de la mantención.
ALTER TABLE DETALLE_SERVICIO
    ADD cod_sucursal CHAR(3) NOT NULL;

ALTER TABLE MANTENCION
    ADD CONSTRAINT MANTENCION_PK
    PRIMARY KEY (num_mantencion, cod_sucursal);

ALTER TABLE DETALLE_SERVICIO
    ADD CONSTRAINT DETALLE_SERVICIO_PK
    PRIMARY KEY (mantencion_num, cod_sucursal, cod_servicio);

ALTER TABLE DETALLE_SERVICIO
    ADD CONSTRAINT DET_SERV_FK_MANTENCION
    FOREIGN KEY (mantencion_num, cod_sucursal)
    REFERENCES MANTENCION (num_mantencion, cod_sucursal);

-- 3. Email opcional, pero único cuando se registra.
ALTER TABLE CLIENTE
    ADD CONSTRAINT CLIENTE_UN_EMAIL UNIQUE (email);

-- 4. DV permitido: 0-9 o K.
ALTER TABLE CLIENTE
    ADD CONSTRAINT CLIENTE_CK_DV
    CHECK (dv IN ('0','1','2','3','4','5','6','7','8','9','K'));

-- 5. Sueldo mínimo del mecánico.
ALTER TABLE MECANICO
    ADD CONSTRAINT MECANICO_CK_SUELDO
    CHECK (sueldo >= 510000);

-- 6. Estados permitidos para una mantención.
ALTER TABLE MANTENCION
    ADD CONSTRAINT MANTENCION_CK_ESTADO
    CHECK (estado IN ('Reserva','Ingresado','Entregado','Anulado'));


-- ============================================================
-- CASO 3: POBLAMIENTO
-- ============================================================

-- Secuencia SERVICIO: 400, 402, 404, 406...
CREATE SEQUENCE SEQ_SERVICIO
    START WITH 400
    INCREMENT BY 2
    NOCACHE
    NOCYCLE;

-- Secuencia CIUDAD: 165, 170, 175...
CREATE SEQUENCE SEQ_CIUDAD
    START WITH 165
    INCREMENT BY 5
    NOCACHE
    NOCYCLE;


-- PAIS: identity genera 9, 12, 15.
INSERT INTO PAIS (nom_pais)
VALUES ('Chile');

INSERT INTO PAIS (nom_pais)
VALUES ('Peru');

INSERT INTO PAIS (nom_pais)
VALUES ('Colombia');


-- CIUDAD
INSERT INTO CIUDAD (id_ciudad, nom_ciudad, cod_pais)
VALUES (SEQ_CIUDAD.NEXTVAL, 'Santiago', 9);

INSERT INTO CIUDAD (id_ciudad, nom_ciudad, cod_pais)
VALUES (SEQ_CIUDAD.NEXTVAL, 'Lima', 12);

INSERT INTO CIUDAD (id_ciudad, nom_ciudad, cod_pais)
VALUES (SEQ_CIUDAD.NEXTVAL, 'Bogotá', 15);


-- SUCURSAL
INSERT INTO SUCURSAL
    (id_sucursal, nom_sucursal, calle, num_calle, cod_ciudad)
VALUES
    ('S01', 'Providencia', 'Av. A. Varas', 234, 165);

INSERT INTO SUCURSAL
    (id_sucursal, nom_sucursal, calle, num_calle, cod_ciudad)
VALUES
    ('S02', 'Las 4 esquinas', 'Av. Latinas', 669, 170);

INSERT INTO SUCURSAL
    (id_sucursal, nom_sucursal, calle, num_calle, cod_ciudad)
VALUES
    ('S03', 'El Cafetero', 'Av. El Faro', 900, 175);


-- SERVICIO
INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (SEQ_SERVICIO.NEXTVAL, 'Cambio Luces', 45000);

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (SEQ_SERVICIO.NEXTVAL, 'Desabolladura', 67000);

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (SEQ_SERVICIO.NEXTVAL, 'Revisión Frenos', 30000);

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (SEQ_SERVICIO.NEXTVAL, 'Cambio Puerta Trasera', 50000);


-- MECANICO
-- Identity genera: 460, 467, 474, 481, 488, 495, 502, 509, 516, 523.
INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Jorge', 'Pablo', 'Soto', 'Sierpe',
     5400000, 2759000, 223580, NULL);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Pedro', 'Jose', 'Manriquez', 'Corral',
     NULL, 759000, 23980, NULL);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Sandra', 'Josefa', 'Letelier', 'S.',
     0, 659000, 22358, 460);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Felipe', 'M.', 'Vidal', 'A.',
     NULL, 759000, 23580, 460);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Jose', 'Miguel', 'Troncoso', 'B.',
     NULL, 659000, 44580, 474);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Juan', 'Pablo', 'Sánchez', 'R.',
     NULL, 859000, 23380, 474);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Carlos', 'Felipe', 'Soto', 'J.',
     0, 597000, 23580, 474);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Alberto', 'P.', 'Cerda', 'Ramírez',
     NULL, 559000, 22380, 460);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Alejandra', 'Gabriela', 'Infanti', 'R.',
     NULL, 659000, 22380, 460);

INSERT INTO MECANICO
    (pnombre, snombre, apaterno, amaterno,
     bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES
    ('Roberto', 'Patricio', 'Gutierrez', 'Sosa',
     NULL, 859000, 22380, 460);


-- MANTENCION
INSERT INTO MANTENCION
    (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida,
     patente_auto, cod_mecanico, estado)
VALUES
    (101, 'S01', TO_DATE('12-04-2023','DD-MM-YYYY'), NULL,
     NULL, 481, 'Reserva');

INSERT INTO MANTENCION
    (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida,
     patente_auto, cod_mecanico, estado)
VALUES
    (102, 'S02', TO_DATE('21-02-2023','DD-MM-YYYY'),
     TO_DATE('21-02-2023','DD-MM-YYYY'),
     NULL, 502, 'Entregado');

INSERT INTO MANTENCION
    (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida,
     patente_auto, cod_mecanico, estado)
VALUES
    (103, 'S02', TO_DATE('09-10-2023','DD-MM-YYYY'), NULL,
     NULL, 502, 'Anulado');

INSERT INTO MANTENCION
    (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida,
     patente_auto, cod_mecanico, estado)
VALUES
    (104, 'S03', TO_DATE('11-08-2023','DD-MM-YYYY'),
     TO_DATE('18-08-2023','DD-MM-YYYY'),
     NULL, 509, 'Entregado');

INSERT INTO MANTENCION
    (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida,
     patente_auto, cod_mecanico, estado)
VALUES
    (105, 'S03', TO_DATE('03-12-2023','DD-MM-YYYY'), NULL,
     NULL, 509, 'Ingresado');

COMMIT;


-- ============================================================
-- CASO 4: RECUPERACIÓN DE DATOS
-- ============================================================

-- INFORME 1
-- Mecánicos sin bono de jefatura y con impuestos inferiores a $40.000.
SELECT
    cod_mecanico AS "ID MECANICO",
    pnombre || ' ' || apaterno AS "NOMBRE MECANICO",
    sueldo AS "SALARIO",
    monto_impuestos AS "IMPUESTO ACTUAL",
    monto_impuestos * 0.80 AS "IMPUESTO REBAJADO",
    sueldo - (monto_impuestos * 0.80) AS "SUELDO CON REBAJA IMPUESTOS"
FROM MECANICO
WHERE bono_jefatura IS NULL
  AND monto_impuestos < 40000
ORDER BY monto_impuestos DESC, apaterno ASC;


-- INFORME 2
-- Mecánicos con sueldo entre $600.000 y $900.000,
-- o aquellos que no tienen supervisor.
SELECT
    cod_mecanico AS "IDENTIFICADOR",
    pnombre || ' ' || snombre || ' ' || apaterno AS "MECANICO",
    sueldo AS "SALARIO ACTUAL",
    sueldo * 0.05 AS "AJUSTE",
    sueldo * 1.05 AS "SUELDO_REAJUSTADO"
FROM MECANICO
WHERE sueldo BETWEEN 600000 AND 900000
   OR cod_supervisor IS NULL
ORDER BY sueldo ASC,
         (pnombre || ' ' || snombre || ' ' || apaterno) DESC;


-- ============================================================
-- FIN
-- ============================================================
