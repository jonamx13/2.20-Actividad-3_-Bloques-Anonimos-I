/*
 * 2. Obtener los nombres de los dos departamentos con el mayor
 * número de empleados.
 *
 * Descripción: Identifica los 2 departamentos con más empleados.
 *
 * Este bloque usa ROWNUM para limitar los resultados a los 2 primeros
 * después de ordenar por cantidad de empleados descendente.
*/

DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE('DEPARTAMENTOS CON MÁS EMPLEADOS');
  DBMS_OUTPUT.PUT_LINE('--------------------------------');
  
  FOR rec IN (
    SELECT d.department_name, COUNT(e.employee_id) AS employee_count
    FROM departments d
    JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_name
    ORDER BY employee_count DESC
    FETCH FIRST 2 ROWS ONLY)
  LOOP
    DBMS_OUTPUT.PUT_LINE(rec.department_name || ': ' || rec.employee_count || ' empleados');
  END LOOP;
END;