# Convención monetaria — AutoAlDía

## Regla general

**Todos los montos monetarios se almacenan como enteros representando la unidad monetaria mínima.**

- COP (default, único soportado en MVP): 1 unidad mínima = **1 peso** → los montos son pesos enteros. Sin decimales.
- Queda prohibido usar `REAL`/`double` para columnas de dinero en SQLite o en modelos de dominio.

## Justificación

El punto flotante (`double`) introduce errores de redondeo acumulados en operaciones financieras recurrentes (sumas de gastos, promedios, totales). Los enteros evitan ese problema y son la práctica estándar para dinero (ej. centavos en USD, pesos en COP).

## Modelado

- Tablas Drift: columnas de monto con `integer()`.
- Modelos de dominio: campos `int`.
- Ejemplos de columnas afectadas: `total_cost`, `unit_price`, `amount`, `cost`, `premium`.

## Conversión para mostrar

La división para mostrar decimales ocurre **solo en el punto de presentación** o en cálculos derivados puntuales (`/ 1` en COP; en una futura multi-moneda, `/ 100` para monedas con centavos). Nunca se persiste el resultado de esa conversión.

## Dónde se aplica

Referencia única: este archivo. Toda tabla y modelo nuevo debe respetar esta convención.

## Supuesto del MVP

Una sola moneda activa por usuario. Guardada en `users.currency` (default `'COP'`). La arquitectura permite sumar monedas nuevas sin migrar tablas financieras.