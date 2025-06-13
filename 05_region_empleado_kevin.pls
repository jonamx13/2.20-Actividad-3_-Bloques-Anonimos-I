/*
 * 5. Obtener la región donde labora el empleado Kevin.
 *
 * Descripción: Determina la región donde trabaja el/los empleado(s) llamado(s) Kevin.
 * Si hay múltiples Kevins, muestra información de cada uno incluyendo su departamento.
 *
 * Este bloque usa múltiples JOINS para rastrear la ubicación
 * del empleado Kevin hasta su región correspondiente.
*/

DECLARE
  v_kevin_count NUMBER;
BEGIN
  -- Contar cuántos Kevins hay
  SELECT COUNT(*) INTO v_kevin_count
  FROM employees
  WHERE UPPER(first_name) = 'KEVIN';
  
  DBMS_OUTPUT.PUT_LINE('Se encontraron ' || v_kevin_count || ' empleados llamados Kevin');
  DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
  
  -- Mostrar información de cada Kevin
  FOR kevin_rec IN (
    SELECT e.employee_id, e.first_name, e.last_name, d.department_name, r.region_name
    FROM employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
    LEFT JOIN locations l ON d.location_id = l.location_id
    LEFT JOIN countries c ON l.country_id = c.country_id
    LEFT JOIN regions r ON c.region_id = r.region_id
    WHERE UPPER(e.first_name) = 'KEVIN')
  LOOP
    DBMS_OUTPUT.PUT_LINE(kevin_rec.first_name || ' ' || kevin_rec.last_name || 
                         ' del departamento ' || NVL(kevin_rec.department_name, 'Sin departamento') || 
                         ', trabaja en la región: ' || NVL(kevin_rec.region_name, 'Desconocida'));
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontró ningún empleado llamado Kevin');
END;