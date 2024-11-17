CREATE DATABASE contabilidadvla;
 
USE contabilidadvla;


-- 6 GRUPOS ESTABLECIDOS COMO CONSTANTES DEL SISTEMA
CREATE TABLE grupos (
	cod_grupo INT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL
);

-- INSERCION DE CONSTANTES
INSERT INTO grupos VALUES 
(1, 'Activos', 'deudora'),
(2, 'Pasivos', 'acreedora'),
(3, 'Patrimonio', 'acreedora'),
(4, 'Ingresos', 'acreedora'),
(5, 'Gastos', 'deudora'),
(6, 'Costos', 'deudora');



-- FASE1 TABLA PARA ADMINISTRAR LOS TIPOS DE CUENTA CONTABLES, ESTARAN ASOCIADOS CUALQUIERA DE LOS GRUPOS
CREATE TABLE catalogo_cuentas (
    cod_cuenta INT  PRIMARY KEY,                     
    nombre VARCHAR(255) NOT NULL,                    
    cod_grupo INT NOT NULL,
    cod_padre INT,                                   
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    prioridad INT NOT NULL,
    FOREIGN KEY (cod_grupo) REFERENCES grupos(cod_grupo),
    FOREIGN KEY (cod_padre) REFERENCES catalogo_cuentas(cod_cuenta)
);

-- INSERSION DE CONSTANTES

INSERT INTO catalogo_cuentas (cod_cuenta, nombre, cod_grupo, cod_padre,prioridad) VALUES 
(1, 'Activos', 1, NULL,0),
(2, 'Pasivos', 2, NULL,0),
(3, 'Patrimonio', 3, NULL,0),
(4, 'Ingresos', 4, NULL,0),
(5, 'Gastos', 5, NULL,0),
(6, 'Costos', 6, NULL,0);


-- LAS SUBCUENTAS IRAN ASOCIADAS CON CUENTAS Y TAMBIEN LAS SUBCUENTAS IRAN ASOCIADAS CON SUBCUENTA A DETALLE
CREATE TABLE subcuentas (
    cod_subcuenta BIGINT PRIMARY KEY,                   -- Identificador único 
    cod_cuenta BIGINT NOT NULL,                         -- Relación con la tabla cuentas
    cod_padre BIGINT,                                   -- Relación jerárquica con la subcuenta padre
    nombre VARCHAR(100) NOT NULL,                       -- Nombre descriptivo de la subcuenta
    tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL,  -- Naturaleza de la subcuenta
    estado TINYINT DEFAULT 1,                           -- Estado de la subcuenta
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de registro
    FOREIGN KEY (cod_padre) REFERENCES subcuentas(cod_subcuenta) -- Relación jerárquica entre subcuentas
);

CREATE TABLE movimientos_diarios (
    cod_movdia BIGINT AUTO_INCREMENT PRIMARY KEY,    -- Identificador único
    cod_subcuenta BIGINT NOT NULL,                    -- Relación con la tabla subcuentas
    tip_movimiento ENUM('acreedora', 'deudora') NOT NULL,  -- Tipo de movimiento (acreedora o deudora)
    val_movimiento DECIMAL(15,2) NOT NULL,            -- Valor del movimiento
    usr_registro VARCHAR(255),                        -- Usuario que registra el movimiento (CURRENT_USER() devuelve el usuario)
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del registro
    FOREIGN KEY (cod_subcuenta) REFERENCES subcuentas(cod_subcuenta) ON DELETE CASCADE -- Relación con subcuentas
);

CREATE TABLE asientos (
    cod_asiento BIGINT AUTO_INCREMENT PRIMARY KEY,     -- Identificador único
    nom_tip_asiento VARCHAR(255) NOT NULL,             -- Nombre del tipo de asiento
    des_tipo VARCHAR(255),                             -- Descripción del tipo de asiento
    fec_asiento DATETIME NOT NULL,                     -- Fecha del asiento
    detalle VARCHAR(255),                              -- Detalles adicionales
    num_asiento INT NOT NULL,                          -- Número de asiento
    ind_asiento ENUM('1', '0') DEFAULT '1',            -- Indicador de asiento activo o inactivo
    usr_registro VARCHAR(255),                         -- Usuario que registra el asiento
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP -- Fecha de registro
);

CREATE TABLE rel_movdia_asientos (
    cod_rel_movdia_asientos BIGINT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    cod_movdia BIGINT NOT NULL,                                -- Relación con la tabla movimientos_diarios
    cod_asiento BIGINT NOT NULL,                               -- Relación con la tabla asientos
    FOREIGN KEY (cod_movdia) REFERENCES movimientos_diarios(cod_movdia),
    FOREIGN KEY (cod_asiento) REFERENCES asientos(cod_asiento) 
);


