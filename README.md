## 🔄 Bloques anónimos en PL/SQL Parte 1

Los **bloques anónimos** son estructuras PL/SQL temporales que:
- No tienen nombre (*anonymous*)
- No se almacenan en la base de datos
- Se ejecutan inmediatamente y desaparecen después
- Son ideales para scripts rápidos o pruebas

### 🛠️ Estructura básica:
```sql
[DECLARE
  -- Variables, cursores, etc (opcional)
BEGIN
  -- Instrucciones SQL/PLSQL
[EXCEPTION
  -- Manejo de errores (opcional)]
END;
]
```

Cada ejercicio incluye:
- ✅ Redacción del problema
- 🔣 Código PL/SQL correspondiente
- 📤 Salida esperada mediante `DBMS_OUTPUT.PUT_LINE`

---

## 🚀 Requisitos

- Oracle Database (se probó en versión 21c)
- Acceso a la base de datos **HR**
- Habilitar la salida de `DBMS_OUTPUT` en tu entorno (ej: SQL Developer, Oracle Live SQL)

---

## 📌 Temas abordados

### 1. `ROLLUP` para subtotales y totales (01_nomina_departamentos.pls)
Uso de la cláusula `ROLLUP` en consultas SQL para generar subtotales por departamento y un total general de nómina, con formato de salida alineado.

### 2. `FETCH FIRST` para limitar resultados (02_departamentos_mas_empleados.pls)
Consulta con cláusula `FETCH FIRST 2 ROWS ONLY` para obtener solo los dos departamentos con más empleados, evitando el uso tradicional de `ROWNUM`.

### 3. Bucles anidados con cursores implícitos (03_empleados_menos_mitad_kevin.pls)
Implementación de bucles anidados donde el bucle exterior procesa cada empleado llamado Kevin y el interior busca empleados que ganen menos de la mitad de su salario.

### 4. Manejo de transacciones y excepciones (04_eliminar_departamento_it.pls)
Uso de `COMMIT` y `ROLLBACK` para control transaccional, combinado con manejo de excepciones específicas (`NO_DATA_FOUND`) y genéricas.

### 5. Múltiples `JOIN` para relaciones complejas (05_region_empleado_kevin.pls)
Cadena de joins (`EMPLOYEES → DEPARTMENTS → LOCATIONS → COUNTRIES → REGIONS`) para rastrear la ubicación geográfica completa de un empleado.

### 6. Formateo avanzado de salida
Uso de funciones como `RPAD`, `TO_CHAR` con formatos numéricos (`L999G999G999D00`) y concatenación para presentación profesional en `DBMS_OUTPUT`.

### 7. Agregación con `GROUP BY`
Agrupaciones de datos con funciones de agregación (`SUM`, `COUNT`) combinadas con cláusulas `GROUP BY` para análisis departamental.


---

## 🧾 Créditos
- **Materia:** Bases de Datos II
- **Asesor:** José Saul De Lira Miramontes
- **Alumno:** Jonathan Eduardo Olivas Meixueiro
- **Matricula:** 240694
- **Fecha de entrega:** 13/Junio/2025