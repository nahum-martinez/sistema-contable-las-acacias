CREATE DATABASE contabilidadvla;
 
USE contabilidadvla;

-- En esta tabla ya estaran definidas por el sistema iran las clases (1- activo 2-pasivo 3-patrimonio 4-ingreso 5-costo 6-gastos )    de ahi no se agregan nada mas 
-- en la misma tabla los grupos (11-AC 12-ANC 21-PC 22-PNC 31-PATRIMONIO 41-INGRESOS 51-COSTO 61-GASTOS) SOLO ESOS
CREATE TABLE catalogo_cuentas (
    cod_catcue INT  PRIMARY KEY,                     -- Identificador único
    nombre VARCHAR(255) NOT NULL,                    -- Nombre de la clase o grupo
    tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL,  -- Naturaleza contable
    cod_padre INT,                                   -- Referencia a la clase o grupo superior (puede ser NULL)
    FOREIGN KEY (cod_padre) REFERENCES catalogo_cuentas(cod_catcue)
);

-- LAS CUENTAS QUE IRAN RELACIONADAS CON LOS GRUPOS 
CREATE TABLE cuentas (
    cod_cuenta BIGINT  PRIMARY KEY,                   -- Identificador único
    cod_catcue INT NOT NULL,                        -- Relación con la tabla catalogo_cuentas
    nombre VARCHAR(100) NOT NULL,                    -- Nombre descriptivo de la cuenta
    tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL, -- Naturaleza de la cuenta
    estado TINYINT DEFAULT 1,                        -- Estado de la cuenta (1 = activa, 0 = inactiva)
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de registro
    FOREIGN KEY (cod_catcue) REFERENCES catalogo_cuentas(cod_catcue)   -- Relación con catalogo_cuentas
);

-- LAS SUBCUENTAS IRAN ASOCIADAS CON CUENTAS Y TAMBIEN LAS SUBCUENTAS IRAN ASOCIADAS CON SUBCUENTA A DETALLE
CREATE TABLE subcuentas (
    cod_subcuenta BIGINT PRIMARY KEY,                   -- Identificador único 
    cod_cuenta BIGINT NOT NULL,                         -- Relación con la tabla cuentas
    cod_padre BIGINT,                                   -- Relación jerárquica con la subcuenta padre
    nombre VARCHAR(100) NOT NULL,                       -- Nombre descriptivo de la subcuenta
    tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL,  -- Naturaleza de la subcuenta
    estado TINYINT DEFAULT 1,                           -- Estado de la subcuenta
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de registro
    FOREIGN KEY (cod_cuenta) REFERENCES cuentas(cod_cuenta), -- Relación con cuentas
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


































































-- ESTA ESTRUCTURA ES YA DETERMINADA  POR EL SISTEMA 
-- Tabla Catalogo Cuentas (para clases y grupos)
CREATE TABLE catalogo_cuentas (
    cod_catcue bigint PRIMARY KEY NOT NULL,         -- Identificador único para cada registro de clase o grupo
    nombre VARCHAR(255) NOT NULL,                     -- Nombre de la clase o grupo
    tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL,  -- Naturaleza contable
    cod_padre BIGINT(20),                             -- Referencia a la clase o grupo superior
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP -- Fecha de creación del registro
);

-- Tabla Cuentas
CREATE TABLE cuentas (
    id_cuenta bigint (10) PRIMARY KEY NOT NULL,          -- Identificador único de la cuenta contable
    cod_catcue bigint(20) NOT NULL,                      -- Relación con la tabla catalogo_cuentas, indica a qué grupo pertenece la cuenta
    nombre VARCHAR(100) NOT NULL,                        -- Nombre descriptivo de la cuenta contable (Ej. Caja, Bancos)
    tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL, -- Tipo de naturaleza contable de la cuenta (acreedora o deudora)
    estado TINYINT DEFAULT 1,                            -- Estado de la cuenta (1 para activa, 0 para inactiva)
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de registro de la cuenta
    FOREIGN KEY (cod_catcue) REFERENCES catalogo_cuentas(cod_catcue)  -- Relación con catalogo_cuentas
);

CREATE TABLE subcuentas (
    id_subcuenta bigint(10) PRIMARY KEY NOT NULL,             -- Identificador único de la subcuenta
    id_cuenta bigint(10) NOT NULL,                            -- Relación con la tabla cuentas
    id_padre bigint(10),                                      -- Relación con la subcuenta "padre" (para subniveles)
    nombre VARCHAR(100) NOT NULL,                              -- Nombre descriptivo de la subcuenta
    tip_naturaleza ENUM('acreedora', 'deudora') NOT NULL,      -- Naturaleza contable (acreedora o deudora)
    estado TINYINT DEFAULT 1,                                  -- Estado de la subcuenta (1 para activa, 0 para inactiva)
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Fecha de registro de la subcuenta
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta) , -- Clave foránea hacia cuentas
    FOREIGN KEY (id_padre) REFERENCES subcuentas(id_subcuenta)  -- Relación jerárquica entre subcuentas
);

-- Tabla Movimientos Diarios
CREATE TABLE movimientos_diarios (
    cod_movdia BIGINT PRIMARY KEY NOT NULL,                    -- Identificador único del movimiento
    cod_subcuenta BIGINT NOT NULL,                             -- Relación con la tabla subcuentas
    tip_movimiento ENUM('acreedora', 'deudora') NOT NULL,      -- Tipo de movimiento
    val_movimiento DECIMAL(15,2) NOT NULL,                     -- Valor del movimiento
    usr_registro VARCHAR(255),                                -- Obtiene el usuario del sistema
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Fecha y hora del registro del movimiento
    FOREIGN KEY (cod_subcuenta) REFERENCES subcuentas(cod_subcuenta) ON DELETE CASCADE
);

-- Tabla Asientos
CREATE TABLE asientos (
    cod_asiento BIGINT PRIMARY KEY NOT NULL,                   -- Identificador único del asiento
    nom_tip_asiento VARCHAR(255) NOT NULL,                     -- Nombre del tipo de asiento
    des_tipo VARCHAR(255),                                     -- Descripción del tipo de asiento
    fec_asiento DATETIME NOT NULL,                             -- Fecha del asiento
    detalle VARCHAR(255),                                      -- Detalles adicionales
    num_asiento INT NOT NULL,                                  -- Número de asiento
    ind_asiento ENUM('1', '0') DEFAULT '1',                    -- Indicador de asiento activo (1) o inactivo (0)
    usr_registro VARCHAR(255),                                 -- Obtiene el usuario del sistema
    fec_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP   -- Fecha de creación del asiento
);

-- Tabla Relación Movimientos Diarios - Asientos
CREATE TABLE rel_movdia_asientos (
    cod_rel_movdia_asientos BIGINT PRIMARY KEY NOT NULL,       -- Identificador único de la relación
    cod_movdia BIGINT NOT NULL,                                -- Relación con la tabla movimientos_diarios
    cod_asiento BIGINT NOT NULL,                               -- Relación con la tabla asientos
    FOREIGN KEY (cod_movdia) REFERENCES movimientos_diarios(cod_movdia) ON DELETE CASCADE,
    FOREIGN KEY (cod_asiento) REFERENCES asientos(cod_asiento) ON DELETE CASCADE
);





































-- Insertar Clases (cod_padre es NULL para clases principales)
INSERT INTO catalogo_cuentas (cod_catcue, nombre, tip_naturaleza, cod_padre) VALUES 
(1, 'Activos', 'deudora', NULL),
(2, 'Pasivos', 'acreedora', NULL),
(3, 'Patrimonio', 'acreedora', NULL),
(4, 'Ingresos', 'acreedora', NULL),
(5, 'Gastos', 'deudora', NULL),
(6, 'Costos', 'deudora', NULL);

-- Insertar Grupos (cod_padre hace referencia a la clase correspondiente)
INSERT INTO catalogo_cuentas (cod_catcue, nombre, tip_naturaleza, cod_padre) VALUES 
(11, 'Activos Corrientes', 'deudora', 1),
(12, 'Activos No Corrientes', 'deudora', 1),
(21, 'Pasivos Corrientes', 'acreedora', 2),
(22, 'Pasivos No Corrientes', 'acreedora', 2),
(31, 'Capital Contable', 'acreedora', 3),
(41, 'Ingresos Operativos', 'acreedora', 4),
(51, 'Gastos Operativos', 'deudora', 5),
(61, 'Costos de Ventas', 'deudora', 6);

    
    

select * from  catalogo_cuentas;