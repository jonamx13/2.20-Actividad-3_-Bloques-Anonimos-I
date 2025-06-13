/*
 * 4. Eliminar el departamento de 'IT', verificar que el departamento
 * no tenga asignado empleados.
 *
 * Descripción: Elimina el departamento IT solo si no tiene empleados.
 *
 * Este bloque verifica primero si hay empleados en el departamento
 * antes de intentar eliminarlo, con manejo de transacciones.
*/

DECLARE
  v_empleados_asignados NUMBER;
  v_dept_id NUMBER;
BEGIN
  -- Obtener ID del departamento IT
  SELECT department_id INTO v_dept_id
  FROM departments
  WHERE UPPER(department_name) = 'IT';
  
  -- Verificar empleados asignados
  SELECT COUNT(*) INTO v_empleados_asignados
  FROM employees
  WHERE department_id = v_dept_id;
  
  IF v_empleados_asignados = 0 THEN
    DELETE FROM departments WHERE department_id = v_dept_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Departamento IT eliminado correctamente.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('No se puede eliminar. Hay ' || v_empleados_asignados || 
                         ' empleados en el departamento IT.');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('El departamento IT no existe');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    ROLLBACK;
END;