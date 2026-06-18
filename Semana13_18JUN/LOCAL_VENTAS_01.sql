SELECT * FROM detalle;

-- Si no hay ninguna fila
-- retorna cero (0).

SELECT COUNT(*) FROM DETALLE
WHERE idprod = 88888;

-- Si no hay ninguna fila que sumar
-- retorna null.

SELECT SUM(SUBTOTAL) FROM DETALLE
WHERE idprod = 88888;




