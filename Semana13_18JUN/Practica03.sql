
CREATE OR REPLACE PACKAGE pkgpc3 as
    
    function fn_precio_prom_vendido(
        p_idprod IN producto.idprod%TYPE
    ) RETURN NUMBER;
    
    function fn_estado_pago_venta(
        p_idventa IN venta.idventa%TYPE
    ) return VARCHAR2;
    
    PROCEDURE pr_retirar_producto_venta(
        p_idventa IN detalle.idventa%TYPE,
        p_idprod IN detalle.idprod%TYPE
    );
    
    FUNCTION fn_producto_mas_vendido_cat(
        p_idcat categoria.idcat%type
    ) RETURN VARCHAR2;

END pkgpc3;
/


CREATE OR REPLACE PACKAGE BODY pkgpc3 as


FUNCTION fn_precio_prom_vendido(
p_idprod IN producto.idprod%TYPE
) RETURN NUMBER
IS
    v_prom NUMBER(10,2);
BEGIN
    SELECT SUM(subtotal) / sum(cant)
    INTO v_prom
    FROM detalle
    WHERE idprod = p_idprod;
    RETURN NVL(v_prom, 0);
END;

function fn_estado_pago_venta(
    p_idventa IN venta.idventa%TYPE
) return VARCHAR2
IS
    V_IMPORTE_VENTA VENTA.IMPORTE%TYPE;
    V_SUMA_PAGOS PAGO.IMPORTE%TYPE;
BEGIN
    SELECT importe INTO v_importe_venta
    FROM VENTA WHERE idventa = p_idventa;

    SELECT SUM(IMPORTE) INTO v_suma_pagos
    FROM PAGO
    WHERE idventa = p_idventa;
    
    v_suma_pagos := NVL(v_suma_pagos,0);
    
    IF(v_suma_pagos = 0) THEN
        RETURN 'SIN PAGO';
    END IF;
    
    IF( V_IMPORTE_VENTA > v_suma_pagos) THEN
        RETURN 'PAGO PARCIAL';
    END IF;
    
    IF( V_IMPORTE_VENTA < v_suma_pagos) THEN
        RETURN 'PAGO EXCEDIDO';
    END IF;
    
    RETURN 'PAGADA';
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'VENTA NO EXISTE';
END;


PROCEDURE pr_retirar_producto_venta(
    p_idventa IN detalle.idventa%TYPE,
    p_idprod IN detalle.idprod%TYPE
)
IS
    v_cant detalle.cant%TYPE;
    v_subtotal detalle.subtotal%TYPE;
BEGIN
    
    -- Varifico si existe la venta
    select count(1) into v_cant
    from venta where idventa = p_idventa;
    
    if( v_cant = 0 ) then
        RAISE_APPLICATION_ERROR(-20001, 'Venta no existe.');
    end if;
    
    -- Verificar si tiene pagos
    select count(1) into v_cant
    from pago where idventa = p_idventa;
    
    if( v_cant > 0 ) then
        RAISE_APPLICATION_ERROR(-20001, 'Ya tiene pagos registrados.');
    end if;
    
    SELECT cant, subtotal   INTO v_cant, v_subtotal
    FROM detalle
    WHERE idventa = p_idventa AND idprod = p_idprod;
    
    DELETE FROM detalle
    WHERE idventa = p_idventa AND idprod = p_idprod;
    
    UPDATE producto
    SET stock = stock + v_cant
    WHERE idprod = p_idprod;
    
    UPDATE venta
    SET importe = importe - v_subtotal
    WHERE idventa = p_idventa;
    
    commit;
    
EXCEPTION

    when others then
        rollback;
        RAISE_APPLICATION_ERROR(-20999, SQLERRM);
    
END;


FUNCTION fn_producto_mas_vendido_cat(
    p_idcat categoria.idcat%type
) RETURN VARCHAR2
IS
    CURSOR C_CAT IS
        SELECT D.IDPROD, P.NOMBRE NOMBRE, SUM(D.CANT) CANT 
        FROM DETALLE D
        JOIN PRODUCTO P ON D.IDPROD = P.IDPROD
        WHERE P.IDCAT = P_IDCAT
        GROUP BY D.IDPROD, P.NOMBRE
        ORDER BY 3 DESC, 1 ASC;
    V_NOMBRE PRODUCTO.NOMBRE%TYPE;
    V_IDPROD PRODUCTO.IDPROD%TYPE;
    V_CANT   DETALLE.CANT%TYPE;
    V_RESPUESTA VARCHAR2(100);
BEGIN
    OPEN C_CAT;
    FETCH C_CAT INTO V_IDPROD, V_NOMBRE, V_CANT;
    IF C_CAT%NOTFOUND THEN
        V_RESPUESTA := 'NO TIENE VENTAS';
    ELSE
        V_RESPUESTA := V_NOMBRE;
    END IF;
    CLOSE C_CAT;
    RETURN V_RESPUESTA;
END;

END pkgpc3;
/

select * from producto;
select pkgpc3.fn_precio_prom_vendido(1055) from dual;

select null + 6 from dual;

select * from venta;
select pkgpc3.fn_estado_pago_venta(13333) from dual;

select * from detalle;


EXEC pkgpc3.pr_retirar_producto_venta(1,1001);

select * from pago where pago.idventa = 1;
delete from pago where pago.idventa = 1;

SELECT * FROM CATEGORIA;

SELECT D.IDPROD, P.NOMBRE NOMBRE, SUM(D.CANT) CANT 
FROM DETALLE D
JOIN PRODUCTO P ON D.IDPROD = P.IDPROD
WHERE P.IDCAT = 501
GROUP BY D.IDPROD, P.NOMBRE
ORDER BY 3 DESC, 1 ASC;


SELECT P.NOMBRE NOMBRE 
FROM DETALLE D
JOIN PRODUCTO P ON D.IDPROD = P.IDPROD
WHERE P.IDCAT = 5014
GROUP BY D.IDPROD, P.NOMBRE
ORDER BY SUM(D.CANT) DESC, D.IDPROD ASC;

SELECT PKGPC3.fn_producto_mas_vendido_cat(501) FROM DUAL;

SELECT NOMBRE 
FROM (
    SELECT D.IDPROD, P.NOMBRE NOMBRE, SUM(D.CANT) CANT 
    FROM DETALLE D
    JOIN PRODUCTO P ON D.IDPROD = P.IDPROD
    WHERE P.IDCAT = 501
    GROUP BY D.IDPROD, P.NOMBRE
    ORDER BY 3 DESC, 1 ASC 
) T
WHERE ROWNUM = 1;

