# PLAN DE DESARROLLO — AutoAlDía

Este documento establece la planificación técnica de construcción, etapas, stack tecnológico, dependencias y estrategia integral de pruebas para **AutoAlDía**, conforme a la subsección **Desarrollo** de la Sección 68 y a los criterios de aceptación de las secciones 54, 65 y 66 del requerimiento.

---

## 1. Cronograma y Etapas de Construcción (MVP)

El desarrollo del MVP se estructura en 10 etapas incrementales y testeables:

| Etapa | Módulo | Descripción Técnica | Estado |
|---|---|---|---|
| **Etapa 1** | **Arquitectura y Core** | Arquitectura limpia (Feature-First), carpetas, sistema de almacenamiento físico (`LocalStorageService`), tema visual y GoRouter con guardas reactivas. | **Completado** |
| **Etapa 2** | **Base de Datos y Modelado** | Esquema Drift/SQLite v1 (12 tablas), claves foráneas activas (`PRAGMA foreign_keys = ON`), cascada, índices y convención monetaria en enteros. | **Completado** |
| **Etapa 3** | **Seguridad y Perfil Local** | Creación de perfil inicial en dispositivo, hash SHA-256 + salt de PIN con `FlutterSecureStorage`, biometría con `LocalAuthentication` y pantallas de onboarding / bloqueo. | **Completado** |
| **Etapa 4** | **Gestión de Vehículos (CRUD)** | Interfaz de garaje, registro/edición de vehículos, selección de vehículo activo global (`activeVehicleControllerProvider`), fotografía del auto y eliminación con limpieza física. | **Completado** |
| **Etapa 5** | **Combustible y Rendimiento** | Registro de tanqueadas, cálculo de consumo promedio (km/galón, km/litro, costo por km), historial ordenable y visualización de tanque lleno. | Pendiente |
| **Etapa 6** | **Mantenimiento y Catálogo** | Catálogo preventivo de servicios con intervalos sugeridos (km/meses), registro de intervenciones, cálculo de próximo vencimiento y costos mecánicos. | Pendiente |
| **Etapa 7** | **Documentos y Vencimientos** | Registro y control de SOAT, RTM, pólizas de seguro e impuestos con semáforo de estados (Verde/Amarillo/Rojo) y adjunto de comprobantes. | Pendiente |
| **Etapa 8** | **Gastos Generales** | Registro rápido de egresos varios (peajes, parqueaderos, lavados, repuestos) clasificados por categoría con resumen acumulado. | Pendiente |
| **Etapa 9** | **Alertas y Notificaciones Locales** | Programación de alertas en el dispositivo con `flutter_local_notifications` (anticipación configurable: 60, 30, 15, 7, 1 días) y centro de alertas visual. | Pendiente |
| **Etapa 10** | **Dashboard y Respaldos Locales** | Integración del Dashboard principal del vehículo activo con KPIs, accesos rápidos y exportación/importación de copias de seguridad (.autoaldia / SQLite). | Pendiente |

---

## 2. Tecnologías y Dependencias Oficiales

### Stack Oficial del MVP (Aprobado y Sin Costo de Infraestructura):
- **Framework:** Flutter (versión estable, Dart ^3.11.4).
- **Gestión de Estado:** `flutter_riverpod: 3.2.1`, `riverpod_annotation: 4.0.2`, `riverpod_generator: 4.0.3`.
- **Navegación:** `go_router: ^17.5.0`.
- **Base de Datos Local:** `drift: 2.31.0`, `sqlite3_flutter_libs: ^0.6.0+eol`, `drift_dev: 2.31.0`.
- **Almacenamiento Seguro:** `flutter_secure_storage: ^11.0.0`.
- **Biometría:** `local_auth: ^3.0.2`.
- **Criptografía:** `crypto: ^3.0.7`.
- **Almacenamiento de Archivos:** `path_provider: ^2.1.6`, `path: ^1.9.0`.
- **Cámara y Galería:** `image_picker: ^1.2.3`.
- **Notificaciones Locales:** `flutter_local_notifications: ^22.3.0`.
- **Preferencias del Sistema:** `shared_preferences: ^2.5.5`.
- **Gráficos:** `fl_chart: ^1.2.0`.
- **Linter & Calidad:** `flutter_lints: ^6.0.0`.

### Tecnologías Excluidas del MVP (Prohibidas en Fase 1, Reservadas para Versiones Futuras):
- Servidores propios, Node.js, NestJS, VPS, Hosting.
- PostgreSQL, MySQL o bases de datos externas.
- Firebase como backend de autenticación en la nube.
- Endpoints REST o paquetes HTTP como fuente primaria de verdad.
- Conexión a internet obligatoria para la funcionalidad central.

---

## 3. Estrategia de Pruebas (Sección 65)

Para garantizar la fiabilidad del sistema antes de su entrega, se aplican cuatro niveles de testing:

### 3.1. Pruebas Unitarias de Dominio (`test/features/*/`)
- **Validadores de Formularios:** Cobertura exhaustiva de reglas en `VehicleValidator` y `ProfileValidator`.
- **Cálculos Financieros y de Consumo:**
  - Consumo promedio entre tanque lleno y tanque lleno.
  - Costo por kilómetro recorrido.
  - Proyección de días y kilometraje restante para mantenimientos.
  - Semáforo de vencimiento según fechas de expedición y caducidad.

### 3.2. Pruebas de Integración de Base de Datos (`test/core/database/`)
- Base de datos SQLite in-memory (`NativeDatabase.memory()`).
- Verificación estricta de:
  - Activación de claves foráneas (`PRAGMA foreign_keys = ON`).
  - Eliminación en cascada física y lógica (`ON DELETE CASCADE`).
  - Restricciones de unicidad (`[user_id, plate]`).
  - Transacciones atómicas al alternar vehículo activo.

### 3.3. Pruebas de Almacenamiento Físico (`test/core/storage/`)
- Verificación del `LocalStorageService` con directorios temporales aislados.
- Creación de subcarpetas (`photos/`, `documents/`, `receipts/`, `backups/`).
- Copia y eliminación recursiva de archivos sin dejar elementos huérfanos.

### 3.4. Pruebas de Interfaz y Navegación (`test/core/router/`)
- Validación de redirecciones reactivas en `GoRouter`:
  - Usuario sin perfil → Redirige a `/profile-setup`.
  - Usuario con PIN no desbloqueado → Redirige a `/pin-lock`.
  - Sesión desbloqueada → Permite navegación al `/dashboard` y sub-ramas del Shell.

---

## 4. Criterios de Aceptación del MVP (Sección 66)

La versión 1.0 se considera completada y lista para entrega cuando:
1. El usuario puede crear su perfil inicial y configurar opcionalmente PIN o biometría.
2. La app bloquea el acceso si el PIN está configurado y se restaura la sesión.
3. El usuario puede registrar, editar, listar y eliminar vehículos con fotografía.
4. Puede seleccionarse un vehículo activo y el Dashboard refleja sus datos de inmediato.
5. Se pueden registrar tanqueadas y ver el historial con métricas de consumo calculadas.
6. Se pueden registrar y programar mantenimientos con alertas por fecha y kilometraje.
7. Se pueden registrar gastos y visualizarlos ordenados por categorías.
8. Se pueden administrar documentos (SOAT, RTM, seguro) con semáforo visual de vencimiento.
9. Se emiten notificaciones locales en el dispositivo con la anticipación seleccionada.
10. La aplicación funciona al 100% de manera offline (sin internet).
11. Se puede exportar e importar una copia de seguridad local completa.
12. La suite de pruebas automatizadas pasa al 100% sin advertencias ni errores.
