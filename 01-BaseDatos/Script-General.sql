-- ================ OBTENER TODOS LOS MOVIMEINTOS DIARIOS
SELECT md.cod_movdia as codMovDia, md.cod_movmaestro as codMovMaestro, md.fecha_movdia as fechaMovdia, 
	md.cod_cuenta as codCuenta, cc.nombre as nombreCuenta, md.concepto_movdia as conceptoMovDia, 
	md.debe_movdia as debeMovDia, md.haber_movdia as haberMovDia
FROM movimientos_diarios md, catalogo_cuentas cc
WHERE md.cod_cuenta = cc.cod_cuenta 
	AND md.fecha_movdia >= :PFIni AND md.fecha_movdia <= :PFFin;


UPDATE movimientos_diarios md SET md.id_estado = 4
WHERE md.cod_movmaestro = :codMovMaestro;

UPDATE movimientos_maestros mm SET mm.id_estado = 4
WHERE mm.cod_movmaestro = :codMovMaestro;

CREATE TRIGGER tr_insert_bit_partida_contable
AFTER INSERT
ON movimientos_maestros FOR EACH ROW
BEGIN 
	INSERT INTO bitacora_partida_contable
		(cod_movmaestro, fecha_movmaestro, id_estado_anterior,id_estado_actual,
		total_debe, total_haber, user_movmaestro, evento)
	VALUES(NEW.cod_movmaestro, NEW.fecha_movmaestro, NEW.id_estado, NEW.id_estado,
		NEW.total_debe, NEW.total_haber, NEW.user_movmaestro, 'NUEVA_PARTIDA');
END;

CREATE TRIGGER tr_update_bit_partida_contable
AFTER UPDATE
ON movimientos_maestros FOR EACH ROW
BEGIN 
	INSERT INTO bitacora_partida_contable
		(cod_movmaestro, fecha_movmaestro, id_estado_anterior,id_estado_actual,
		total_debe, total_haber, user_movmaestro, evento)
	VALUES(NEW.cod_movmaestro, NEW.fecha_movmaestro, OLD.id_estado, NEW.id_estado,
		NEW.total_debe, NEW.total_haber, NEW.user_movmaestro, 'ANULA_PARTIDA');
END;


GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;

-- +++++++++++++++++++++ Triggers
CREATE TRIGGER tr_insert_bit_partida_contable
AFTER INSERT
ON movimientos_maestros FOR EACH ROW
BEGIN 
	INSERT INTO bitacora_partida_contable
		(cod_movmaestro, fecha_movmaestro, id_estado_anterior,id_estado_actual,
		total_debe, total_haber, user_movmaestro, evento)
	VALUES(NEW.cod_movmaestro, NEW.fecha_movmaestro, NEW.id_estado, NEW.id_estado,
		NEW.total_debe, NEW.total_haber, NEW.user_movmaestro, 'NUEVA_PARTIDA');
END;

CREATE TRIGGER tr_update_bit_partida_contable
AFTER UPDATE
ON movimientos_maestros FOR EACH ROW
BEGIN 
	INSERT INTO bitacora_partida_contable
		(cod_movmaestro, fecha_movmaestro, id_estado_anterior,id_estado_actual,
		total_debe, total_haber, user_movmaestro, evento)
	VALUES(NEW.cod_movmaestro, NEW.fecha_movmaestro, OLD.id_estado, NEW.id_estado,
		NEW.total_debe, NEW.total_haber, NEW.user_movmaestro, 'ANULA_PARTIDA');
END;

-- +++++++++++++++++++++ Libro Mayor
SELECT  cc.cod_cuenta codCuenta, cc.nombre nombreCuenta, 
		md.cod_movmaestro codMovMaestro, md.fecha_movdia fechaMovdia,
		md.debe_movdia debeMovDia, md.haber_movdia haberMovDia,
		e.id idEstado, e.nombre estadoPartida 
FROM movimientos_diarios md,
	 catalogo_cuentas cc,
	 estados e
WHERE md.cod_cuenta = cc.cod_cuenta 
	 AND md.fecha_movdia >= :PFIni AND md.fecha_movdia <= :PFFin
	 AND md.id_estado = e.id
	 AND md.cod_cuenta like '%%'
ORDER BY cc.cod_grupo, cc.cod_cuenta, md.fecha_movdia;

-- ++++++++++++++++++++++ Balanza de Comprobacion
SELECT  cc.cod_cuenta, cc.nombre,
		SUM(md.debe_movdia) as total_debe, SUM(md.haber_movdia) as total_haber,
		CASE 
			WHEN (cc.cod_grupo = 1 OR cc.cod_grupo = 5 OR cc.cod_grupo = 6)  THEN SUM(md.debe_movdia) - SUM(md.haber_movdia)
			ELSE 0
		END as saldo_deudor,
		CASE 
			WHEN (cc.cod_grupo = 2 OR cc.cod_grupo = 3 OR cc.cod_grupo = 4  ) THEN SUM(md.debe_movdia) - SUM(md.haber_movdia)
			ELSE 0
		END as saldo_acreedor
FROM movimientos_diarios md,
	 catalogo_cuentas cc
WHERE md.cod_cuenta = cc.cod_cuenta 
	 AND md.fecha_movdia >= :PFIni AND md.fecha_movdia <= :PFFin
	 AND md.id_estado = 3
GROUP BY cc.cod_cuenta, cc.nombre
ORDER BY cc.cod_grupo;
