-- ============================================================
-- PRY2204 - Evaluación Final Transversal - Semana 9
-- Caso: Asociación Nacional de Fútbol Profesional (ANFP)
-- Script final de implementación, poblamiento y consultas
-- Oracle Database 21c
-- ============================================================


-- ============================================================
-- 0. LIMPIEZA SEGURA
-- Permite volver a ejecutar el script completo.
-- ============================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DOMINIO_IDIOMA CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE HISTORIAL_CLUB CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PERSONAL_PLANTA CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE JUGADOR CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TRABAJADOR CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ESCUELA_FUTBOL CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE IDIOMA CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ASOCIACION CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CLUB_FUTBOL CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE NACIONALIDAD CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ESTADO_CIVIL CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE GENERO CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE COMUNA CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE REGION CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_CLUB_FUTBOL';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/


-- ============================================================
-- FASE 3 - CREACIÓN DEL ESQUEMA
-- ============================================================

CREATE TABLE REGION (
    id_region      NUMBER(2)      NOT NULL,
    nombre_region  VARCHAR2(60)   NOT NULL,
    CONSTRAINT REGION_PK PRIMARY KEY (id_region)
);

CREATE TABLE COMUNA (
    id_comuna      NUMBER(5)      NOT NULL,
    nombre_comuna  VARCHAR2(60)   NOT NULL,
    id_region      NUMBER(2)      NOT NULL,
    CONSTRAINT COMUNA_PK PRIMARY KEY (id_comuna),
    CONSTRAINT COMUNA_REGION_FK
        FOREIGN KEY (id_region) REFERENCES REGION(id_region)
);

CREATE TABLE GENERO (
    id_genero      NUMBER(2)      NOT NULL,
    descripcion    VARCHAR2(30)   NOT NULL,
    CONSTRAINT GENERO_PK PRIMARY KEY (id_genero),
    CONSTRAINT GENERO_DESCRIPCION_UN UNIQUE (descripcion)
);

CREATE TABLE ESTADO_CIVIL (
    id_estado_civil NUMBER(2)     NOT NULL,
    descripcion     VARCHAR2(30)  NOT NULL,
    CONSTRAINT ESTADO_CIVIL_PK PRIMARY KEY (id_estado_civil),
    CONSTRAINT ESTADO_CIVIL_DESC_UN UNIQUE (descripcion)
);

CREATE TABLE NACIONALIDAD (
    id_nacionalidad NUMBER(3)
        GENERATED ALWAYS AS IDENTITY
        (START WITH 210 INCREMENT BY 2),
    descripcion      VARCHAR2(40) NOT NULL,
    CONSTRAINT NACIONALIDAD_PK PRIMARY KEY (id_nacionalidad),
    CONSTRAINT NACIONALIDAD_DESC_UN UNIQUE (descripcion)
);

CREATE TABLE IDIOMA (
    id_idioma      NUMBER(3)      NOT NULL,
    nombre_idioma  VARCHAR2(40)   NOT NULL,
    CONSTRAINT IDIOMA_PK PRIMARY KEY (id_idioma),
    CONSTRAINT IDIOMA_NOMBRE_UN UNIQUE (nombre_idioma)
);

CREATE TABLE ASOCIACION (
    id_asociacion      NUMBER(3)      NOT NULL,
    nombre_asociacion  VARCHAR2(100)  NOT NULL,
    fecha_creacion     DATE           NOT NULL,
    tipo_asociacion    CHAR(1)        NOT NULL,
    CONSTRAINT ASOCIACION_PK PRIMARY KEY (id_asociacion),
    CONSTRAINT ASOCIACION_FECHA_CK
        CHECK (fecha_creacion >= DATE '1980-12-31'),
    CONSTRAINT ASOCIACION_TIPO_CK
        CHECK (tipo_asociacion IN ('P','A'))
);

CREATE TABLE ESCUELA_FUTBOL (
    id_escuela       NUMBER(5)       NOT NULL,
    nombre_escuela   VARCHAR2(100)   NOT NULL,
    capacidad        NUMBER(6)       NOT NULL,
    fecha_fundacion  DATE            NOT NULL,
    CONSTRAINT ESCUELA_FUTBOL_PK PRIMARY KEY (id_escuela)
);

CREATE TABLE CLUB_FUTBOL (
    id_club           NUMBER(5)       NOT NULL,
    nombre_club       VARCHAR2(100)   NOT NULL,
    patrimonio        NUMBER(15)      NOT NULL,
    ubicacion_calle   VARCHAR2(150)   NOT NULL,
    tipo_club         VARCHAR2(20)    NOT NULL,
    CONSTRAINT CLUB_FUTBOL_PK PRIMARY KEY (id_club),
    CONSTRAINT CLUB_FUTBOL_NOMBRE_UN UNIQUE (nombre_club),
    CONSTRAINT CLUB_FUTBOL_TIPO_CK
        CHECK (tipo_club IN ('Profesional','Amateur'))
);

CREATE TABLE TRABAJADOR (
    cod_inscripcion   NUMBER(10)      NOT NULL,
    rut               NUMBER(8)       NOT NULL,
    dv                CHAR(1)         NOT NULL,
    nombres           VARCHAR2(80)    NOT NULL,
    apellidos         VARCHAR2(80)    NOT NULL,
    sueldo_base       NUMBER(10)      NOT NULL,
    fecha_nacimiento  DATE            NOT NULL,
    email             VARCHAR2(120),
    telefono_movil    VARCHAR2(20)    NOT NULL,
    direccion         VARCHAR2(150)   NOT NULL,
    id_comuna         NUMBER(5)       NOT NULL,
    id_genero         NUMBER(2)       NOT NULL,
    id_estado_civil   NUMBER(2)       NOT NULL,
    id_nacionalidad   NUMBER(3)       NOT NULL,
    CONSTRAINT TRABAJADOR_PK PRIMARY KEY (cod_inscripcion),
    CONSTRAINT TRABAJADOR_RUT_UN UNIQUE (rut),
    CONSTRAINT TRABAJADOR_DV_CK
        CHECK (dv IN ('0','1','2','3','4','5','6','7','8','9','K')),
    CONSTRAINT TRABAJADOR_COMUNA_FK
        FOREIGN KEY (id_comuna) REFERENCES COMUNA(id_comuna),
    CONSTRAINT TRABAJADOR_GENERO_FK
        FOREIGN KEY (id_genero) REFERENCES GENERO(id_genero),
    CONSTRAINT TRABAJADOR_EST_CIVIL_FK
        FOREIGN KEY (id_estado_civil) REFERENCES ESTADO_CIVIL(id_estado_civil),
    CONSTRAINT TRABAJADOR_NACIONALIDAD_FK
        FOREIGN KEY (id_nacionalidad) REFERENCES NACIONALIDAD(id_nacionalidad)
);

CREATE TABLE JUGADOR (
    cod_inscripcion      NUMBER(10)    NOT NULL,
    puesto_campo         VARCHAR2(40)  NOT NULL,
    premios_acumulados   NUMBER(12)    NOT NULL,
    id_asociacion        NUMBER(3)     NOT NULL,
    id_escuela           NUMBER(5),
    anio_fin_amateurismo NUMBER(4),
    CONSTRAINT JUGADOR_PK PRIMARY KEY (cod_inscripcion),
    CONSTRAINT JUGADOR_TRABAJADOR_FK
        FOREIGN KEY (cod_inscripcion)
        REFERENCES TRABAJADOR(cod_inscripcion),
    CONSTRAINT JUGADOR_ASOCIACION_FK
        FOREIGN KEY (id_asociacion)
        REFERENCES ASOCIACION(id_asociacion),
    CONSTRAINT JUGADOR_ESCUELA_FK
        FOREIGN KEY (id_escuela)
        REFERENCES ESCUELA_FUTBOL(id_escuela)
);

CREATE TABLE PERSONAL_PLANTA (
    cod_inscripcion   NUMBER(10)   NOT NULL,
    horas_trabajadas  NUMBER(6,2),
    valor_hora_extra  NUMBER(10),
    id_club           NUMBER(5)    NOT NULL,
    CONSTRAINT PERSONAL_PLANTA_PK PRIMARY KEY (cod_inscripcion),
    CONSTRAINT PERSONAL_PLANTA_TRAB_FK
        FOREIGN KEY (cod_inscripcion)
        REFERENCES TRABAJADOR(cod_inscripcion),
    CONSTRAINT PERSONAL_PLANTA_CLUB_FK
        FOREIGN KEY (id_club)
        REFERENCES CLUB_FUTBOL(id_club)
);

CREATE TABLE HISTORIAL_CLUB (
    cod_inscripcion  NUMBER(10) NOT NULL,
    id_club          NUMBER(5)  NOT NULL,
    fecha_inicio     DATE       NOT NULL,
    fecha_fin        DATE,
    CONSTRAINT HISTORIAL_CLUB_PK
        PRIMARY KEY (cod_inscripcion, id_club, fecha_inicio),
    CONSTRAINT HISTORIAL_CLUB_JUGADOR_FK
        FOREIGN KEY (cod_inscripcion)
        REFERENCES JUGADOR(cod_inscripcion),
    CONSTRAINT HISTORIAL_CLUB_CLUB_FK
        FOREIGN KEY (id_club)
        REFERENCES CLUB_FUTBOL(id_club),
    CONSTRAINT HISTORIAL_CLUB_FECHAS_CK
        CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE DOMINIO_IDIOMA (
    cod_inscripcion  NUMBER(10)   NOT NULL,
    id_idioma        NUMBER(3)    NOT NULL,
    nivel_dominio    VARCHAR2(30) NOT NULL,
    CONSTRAINT DOMINIO_IDIOMA_PK
        PRIMARY KEY (cod_inscripcion, id_idioma),
    CONSTRAINT DOMINIO_IDIOMA_JUGADOR_FK
        FOREIGN KEY (cod_inscripcion)
        REFERENCES JUGADOR(cod_inscripcion),
    CONSTRAINT DOMINIO_IDIOMA_IDIOMA_FK
        FOREIGN KEY (id_idioma)
        REFERENCES IDIOMA(id_idioma)
);


-- La EFT exige secuencia para CLUB_FUTBOL:
-- comienza en 703 y aumenta de 4 en 4.
CREATE SEQUENCE SEQ_CLUB_FUTBOL
    START WITH 703
    INCREMENT BY 4
    NOCACHE
    NOCYCLE;


-- ============================================================
-- FASE 3 - POBLAMIENTO
-- Se pueblan únicamente las tablas indicadas por la EFT.
-- ============================================================

-- REGION
INSERT INTO REGION VALUES (1,  'ARICA Y PARINACOTA Y TARAPACA');
INSERT INTO REGION VALUES (2,  'ANTOFAGASTA');
INSERT INTO REGION VALUES (3,  'ATACAMA Y COQUIMBO');
INSERT INTO REGION VALUES (5,  'VALPARAISO');
INSERT INTO REGION VALUES (13, 'METROPOLITANA');

-- La Figura 2 referencia además las regiones 8 y 16 desde COMUNA.
-- Se agregan para mantener integridad referencial del poblamiento.
INSERT INTO REGION VALUES (8,  'BIOBIO');
INSERT INTO REGION VALUES (16, 'NUBLE');


-- COMUNA
INSERT INTO COMUNA VALUES (101, 'Santiago',    13);
INSERT INTO COMUNA VALUES (102, 'Valparaiso',   5);
INSERT INTO COMUNA VALUES (103, 'Concepcion',   8);
INSERT INTO COMUNA VALUES (104, 'Antofagasta',  2);
INSERT INTO COMUNA VALUES (105, 'Chillan',     16);


-- ASOCIACION
INSERT INTO ASOCIACION VALUES
(25, 'Asociación de Fútbol de Santiago',
 TO_DATE('15-05-2001','DD-MM-YYYY'), 'P');

INSERT INTO ASOCIACION VALUES
(26, 'Asociación Nacional de Fútbol Amateur',
 TO_DATE('10-03-1998','DD-MM-YYYY'), 'A');

INSERT INTO ASOCIACION VALUES
(27, 'Asociación de Fútbol de Valparaíso',
 TO_DATE('21-07-1987','DD-MM-YYYY'), 'P');

INSERT INTO ASOCIACION VALUES
(28, 'Asociación de Fútbol de Concepción',
 TO_DATE('30-11-1995','DD-MM-YYYY'), 'A');

INSERT INTO ASOCIACION VALUES
(29, 'Asociación de Fútbol de Antofagasta',
 TO_DATE('25-06-2003','DD-MM-YYYY'), 'P');

INSERT INTO ASOCIACION VALUES
(30, 'Asociación de Fútbol de Temuco',
 TO_DATE('12-01-2010','DD-MM-YYYY'), 'A');

INSERT INTO ASOCIACION VALUES
(31, 'Asociación de Fútbol de Rancagua',
 TO_DATE('08-09-1999','DD-MM-YYYY'), 'P');

INSERT INTO ASOCIACION VALUES
(32, 'Asociación de Fútbol de Puerto Montt',
 TO_DATE('20-04-2005','DD-MM-YYYY'), 'A');

INSERT INTO ASOCIACION VALUES
(33, 'Asociación de Fútbol de La Serena',
 TO_DATE('14-08-2012','DD-MM-YYYY'), 'P');

INSERT INTO ASOCIACION VALUES
(34, 'Asociación de Fútbol de Chillán',
 TO_DATE('01-12-2018','DD-MM-YYYY'), 'A');


-- NACIONALIDAD
-- El IDENTITY genera 210, 212, 214, 216 y 218.
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Chilena');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Argentina');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Peruana');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Boliviana');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Brasilena');


-- CLUB_FUTBOL
-- La secuencia genera 703, 707, 711, 715 y 719.
INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (SEQ_CLUB_FUTBOL.NEXTVAL, 'Cobreloa', 50000000,
     'Av. Marathon 5300', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (SEQ_CLUB_FUTBOL.NEXTVAL, 'Universidad de Chile', 450000000,
     'Av. El Parrón 0931', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (SEQ_CLUB_FUTBOL.NEXTVAL, 'Deportes Antofagasta', 180000000,
     'Avenida Angamos 01606', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (SEQ_CLUB_FUTBOL.NEXTVAL, 'Huachipato', 220000000,
     'Avenida Desiderio Garcia 909', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (id_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (SEQ_CLUB_FUTBOL.NEXTVAL, 'Nublense', 170000000,
     'Avenida Pedro Aguirre Cerda 1003', 'Profesional');

COMMIT;


-- ============================================================
-- FASE 4 - RECUPERACIÓN DE DATOS
-- ============================================================

-- INFORME 1: Asociaciones de fútbol profesional creadas
-- después del año 2000, ordenadas por fecha descendente.
SELECT
    'ID:' || id_asociacion || ' * ' || nombre_asociacion AS "ASOCIACION",
    TO_CHAR(fecha_creacion, 'DD-MM-YYYY') AS "CREADA",
    tipo_asociacion AS "TIPO"
FROM ASOCIACION
WHERE tipo_asociacion = 'P'
  AND fecha_creacion > DATE '2000-12-31'
ORDER BY fecha_creacion DESC;


-- INFORME 2: Patrimonio de clubes en CLP y USD.
-- Tipo de cambio: $955 por dólar.
SELECT
    id_club AS "CLUB",
    nombre_club AS "NOMBRE CLUB",
    patrimonio AS "PATRIMONIO EN PESOS",
    patrimonio / 955 AS "PATRIMONIO EN DOLARES"
FROM CLUB_FUTBOL
WHERE LOWER(nombre_club) LIKE '%a%'
  AND patrimonio > 200000000
  AND tipo_club = 'Profesional'
ORDER BY id_club DESC;

-- ============================================================
-- FIN
-- ============================================================
