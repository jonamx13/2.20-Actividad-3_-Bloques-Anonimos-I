/*
 * 1. Obtener la nómina que paga cada uno de los departamentos
 * y la nómina total de la compañía.
 *
 * Descripción: Calcula salarios por departamento diferenciando
 * entre empleados sin departamento y el total general.

 * Este bloque usa un CURSOR explícito con la cláusula ROLLUP para
 * generar subtotales por departamento y un total general, mostrando
 * los resultados formateados con alineación de columnas.
*/

DECLARE
  CURSOR c_nomina IS
    SELECT 
      CASE 
        WHEN GROUPING(d.department_name) = 1 AND d.department_name IS NULL THEN 'TOTAL DE LA COMPAÑÍA'
        WHEN d.department_name IS NULL THEN 'Sin departamento'
        ELSE d.department_name
      END AS department_name,
      SUM(e.salary) AS total_salary
    FROM employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
    GROUP BY ROLLUP(d.department_name);
BEGIN
  DBMS_OUTPUT.PUT_LINE('NÓMINA POR DEPARTAMENTO');
  DBMS_OUTPUT.PUT_LINE('-----------------------');
  DBMS_OUTPUT.PUT_LINE(RPAD('Departamento', 20) || 'Nómina');
  
  FOR rec IN c_nomina LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(rec.department_name, 20) || 
                         TO_CHAR(rec.total_salary, 'L999G999G999D00'));
  END LOOP;
END;