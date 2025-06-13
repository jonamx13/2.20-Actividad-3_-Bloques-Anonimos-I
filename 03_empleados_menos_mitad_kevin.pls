/*
 * 3. Con base en el salario de Kevin, obtener los nombres de los empleados
 * que ganan menos de la mitad de dicho salario.
 *
 * Descripción: Busca empleados que ganen menos de la mitad del salario de cada Kevin.
 * Muestra información con apellidos en mayúsculas según requerimiento.

 * Este bloque utiliza BUCLES ANIDADOS: el primero para iterar sobre cada empleado
 * llamado Kevin, y el segundo para encontrar empleados que ganen menos de la mitad
 * del salario de cada Kevin específico, con manejo de casos sin resultados.
*/

DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE('INFORMACIÓN DE EMPLEADOS LLAMADOS KEVIN');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------');
  
  FOR kevin_rec IN (
    SELECT e.first_name, e.last_name, e.salary, 
           NVL(d.department_name, 'Sin departamento') AS department_name
    FROM employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
    WHERE UPPER(e.first_name) = 'KEVIN'
    ORDER BY e.salary DESC
  ) LOOP
    -- Mostrar información del Kevin actual con apellido en mayúsculas
    DBMS_OUTPUT.PUT_LINE('Kevin ' || UPPER(kevin_rec.last_name) || 
                        ' del departamento "' || kevin_rec.department_name || 
                        '" (Salario: $' || kevin_rec.salary || ')');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('EMPLEADOS QUE GANAN MENOS DE LA MITAD DEL SALARIO DE KEVIN ' || UPPER(kevin_rec.last_name) || ':');
    
    -- Buscar empleados para este Kevin específico
    FOR emp_rec IN (
      SELECT e.first_name, e.last_name, e.salary, 
             NVL(d.department_name, 'Sin departamento') AS department_name
      FROM employees e
      LEFT JOIN departments d ON e.department_id = d.department_id
      WHERE e.salary < (kevin_rec.salary/2)
      AND NOT (UPPER(e.first_name) = 'KEVIN' AND e.last_name = kevin_rec.last_name)
      ORDER BY e.salary DESC
    ) LOOP
      DBMS_OUTPUT.PUT_LINE('- ' || emp_rec.first_name || ' ' || emp_rec.last_name || 
                          ' (' || emp_rec.department_name || '): $' || emp_rec.salary);
    END LOOP;
    
    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('(No se encontraron empleados para este criterio)');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
  END LOOP;
  
  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No se encontró ningún empleado llamado Kevin');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;