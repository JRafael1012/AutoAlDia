# ARQUITECTURA TÉCNICA — AutoAlDía

Este documento establece la arquitectura oficial del proyecto **AutoAlDía** (*"Todo tu vehículo, siempre al día"*), cumpliendo formalmente con lo especificado en la **Sección 68 (Antes de iniciar el desarrollo)** del documento de requerimientos del sistema.

---

## 1. Contexto y Visión General

**AutoAlDía** es una solución móvil diseñada para la administración centralizada e integral de vehículos. 
- **Filosofía del MVP (v1.0):** **Offline-First (100% Local)**.
- **Sin Dependencia de Red:** La información se procesa y persiste enteramente en el dispositivo mediante SQLite y el sistema de archivos local, garantizando alta velocidad, nulo costo de infraestructura en la fase inicial y privacidad absoluta para el usuario.
- **Preparación Evolutiva:** La arquitectura modular y desacoplada permite que en versiones posteriores (v2.0 / v3.0) se incorporen sincronización con backend REST (API/Dio), soporte multi-dispositivo y telemetría (GPS / OBD-II) **sin necesidad de reescribir la capa de presentación ni la capa de dominio**.

---

## 2. Pilar 1: Arquitectura del Proyecto

Se adopta una **Clean Architecture modular guiada por funcionalidades (Feature-First)**.

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTACIÓN (UI)                        │
│         Screens, Widgets, Providers (Riverpod Notifiers)    │
└──────────────────────────────┬──────────────────────────────┘
                               │ depende de
▼
┌─────────────────────────────────────────────────────────────┐
│                    DOMINIO (Negocio)                        │
│     Entidades Inmutables, Interfaces de Repositorios,       │
│                Validadores, Reglas de Negocio               │
└──────────────────────────────▲──────────────────────────────┘
                               │ implementa
┌──────────────────────────────┴─────────────────────────────┐
│                       DATOS (Data)                          │
│     Tablas Drift (SQLite), DAOs, Repositories Impl,        │
│                Mappers (Row ↔ Domain Model)                 │
└──────────────────────────────┬──────────────────────────────┘
                               │ utiliza
┌──────────────────────────────┴──────────────────────────────┐
│                    CORE / SERVICIOS                         │
│  Base de Datos (Drift), Almacenamiento Físico (Archivos),    │
│  Seguridad (Keyring/PIN), Notificaciones, Enrutador, Tema   │
└─────────────────────────────────────────────────────────────┘
```

### Reglas Estrictas de Dependencia:
1. **Aislamiento del Dominio (`domain/`):**
   - **Prohibido importar Flutter** (ni `material.dart`, ni widgets).
   - **Prohibido importar Drift o SQLite** (ni `drift.dart`, ni tablas generadas).
   - El dominio contiene exclusivamente tipos Dart puros, lógica de negocio y contratos abstractos (`abstract class VehicleRepository`).
2. **Capa de Datos (`data/`):**
   - Conoce las tablas Drift y los DAOs.
   - Es responsable de transformar las filas de la base de datos a modelos de dominio inmutables a través de funciones puras (`toDomain()`, `toCompanion()`).
3. **Capa de Presentación (`presentation/`):**
   - Consume únicamente los repositorios a través de los providers de Riverpod.
   - No interactúa directamente con la base de datos ni con los DAOs.
4. **Preparación para la Nube:**
   - La futura incorporación de sincronización remota simplemente añadirá un `RemoteDataSource` dentro de `data/` y un mecanismo de resolución de conflictos, manteniendo intactas las pantallas y modelos de dominio.

---

## 3. Pilar 2: Estructura de Carpetas

El árbol de directorios del proyecto en `lib/` se organiza de forma canónica y predecible:

```
lib/
├── core/                               # Módulos transversales a toda la aplicación
│   ├── constants/                      # Constantes del sistema, convenciones monetarias y unidades
│   ├── database/                       # Instancia de Drift (AppDatabase), tablas globales (attachments, logs)
│   ├── errors/                         # Tipos de error de dominio (AppFailure) y mapeador de excepciones
│   ├── notifications/                  # Servicio de notificaciones locales (flutter_local_notifications)
│   ├── router/                         # Configuración de GoRouter, rutas, guards de acceso y Scaffold shell
│   ├── security/                       # Repositorio de PIN seguro (SHA-256 + salt) y biometría (local_auth)
│   ├── storage/                        # LocalStorageService: fotos, comprobantes y carpetas físicas
│   ├── theme/                          # Paleta de colores (AppColors), semáforos de estado y AppTheme
│   └── utils/                          # Formateadores (moneda, fechas, kilometraje) y extensiones
│
├── features/                           # Funcionalidades de negocio (Feature-First)
│   ├── auth/                           # Perfil local, bloqueo por PIN y biometría
│   ├── vehicles/                       # CRUD de vehículos, especificaciones técnicas y vehículo activo
│   ├── dashboard/                      # Vista principal, métricas globales y resumen del vehículo
│   ├── fuel/                           # Registro de combustible, odómetro y cálculos de rendimiento
│   ├── maintenance/                    # Registro de servicios, catálogo preventivo y programación
│   ├── expenses/                       # Gastos generales (peajes, parqueaderos, lavados, repuestos)
│   ├── documents/                      # SOAT, Técnico-mecánica, Seguros, Impuestos y Licencias
│   ├── alerts/                         # Centro unificado de alertas y recordatorios
│   ├── reports/                        # Estadísticas, gráficos comparativos (fl_chart) y métricas
│   ├── backups/                        # Exportación e importación de respaldos locales
│   ├── budgets/                        # Presupuestos mensuales (fase 1.5)
│   ├── loans/                          # Créditos y cuotas (fase 1.5)
│   ├── recurring_payments/             # Pagos fijos periódicos (fase 1.5)
│   ├── workshops/                      # Directorio de talleres (fase 1.5)
│   ├── drivers/                        # Conductores asociados (fase 2.0)
│   ├── trips/                          # Bitácora de viajes (fase 2.0)
│   └── settings/                       # Preferencias de usuario, unidades, moneda y seguridad
│
├── shared/                             # Componentes UI y utilidades compartidas entre features
│   ├── components/                     # Componentes compuestos reutilizables
│   ├── helpers/                        # Helpers de interfaz
│   ├── models/                         # Modelos o tipos comunes (ej. TipoMoneda, TipoCombustible)
│   └── widgets/                        # Botones primarios, inputs con estilo, tarjetas de estado
│
└── main.dart                           # Punto de entrada de la aplicación
```

### Estructura Interna de cada `feature/`:
Toda funcionalidad principal implementa el tríptico de capas:
- `features/<nombre>/data/` (`tables/`, `daos/`, `*_repository_impl.dart`)
- `features/<nombre>/domain/` (`models/`, `repository.dart`, `*_validator.dart`)
- `features/<nombre>/presentation/` (`screens/`, `widgets/`, `providers/`)

---

## 4. Pilar 3: Gestión de Estado

Se utiliza **Riverpod v3** con generación de código (`@riverpod`, `riverpod_annotation`, `riverpod_generator`).

### Categorías de Estado y Convenciones:
1. **Estado Global de Sesión y Acceso:**
   - `profileControllerProvider` (`AsyncNotifier<UserProfile?>`): Detecta si el usuario ya registró su perfil local.
   - `hasPinControllerProvider` (`AsyncNotifier<bool>`): Indica si se configuró protección por PIN.
   - `pinUnlockControllerProvider` (`Notifier<bool>`): Estado en memoria (se reinicia al cerrar la app) que indica si la sesión actual ha sido desbloqueada.
2. **Estado Global de Vehículo Activo:**
   - `activeVehicleControllerProvider` (`AsyncNotifier<VehicleProfile?>`): Mantiene en memoria y persiste en preferencias el ID del vehículo sobre el cual operan los módulos de combustible, gastos y dashboard.
3. **Estado de Datos Reactivos (Streams de Drift):**
   - Los DAOs exponen streams (`watchAllVehicles()`, `watchExpensesForVehicle()`).
   - Los providers de Riverpod consumen estos streams, permitiendo que cualquier inserción o cambio en SQLite actualice la UI de inmediato de forma reactiva, sin recargas manuales.
4. **Estado de Formularios:**
   - Controladores locales por pantalla (`AutoDisposeNotifier`) para validar campos antes de persistir, evitando retener memoria innecesaria.
5. **Estado Derivado:**
   - Providers calculados que derivan información a partir de colecciones existentes (ej. cálculo de gasto mensual, rendimiento km/galón, total pagado en créditos).

---

## 5. Pilar 4: Sistema de Navegación

La navegación es gestionada de forma declarativa y centralizada mediante **GoRouter**.

### Ubicación: `lib/core/router/`
- `app_routes.dart`: Definición de nombres constantes (`AppRoutes`) y rutas absolutas.
- `app_router.dart`: Instancia del router expuesta mediante Riverpod (`goRouterProvider`).
- `main_shell_scaffold.dart`: `StatefulShellRoute` con la barra de navegación persistente (`NavigationBar` Material 3).

### Redirección Reactiva y Guardas (`redirect`):
El router reacciona a los cambios en los proveedores de autenticación:
1. **Sin perfil creado:** Cualquier intento de navegación redirige automáticamente a `/profile-setup`.
2. **Con PIN activo y sesión bloqueada:** Redirige automáticamente a `/pin-lock`.
3. **Sesión desbloqueada:** Si el usuario intenta navegar a `/profile-setup` o `/pin-lock`, se le redirige automáticamente a `/dashboard`.

### Pestañas Principales en el Shell:
- **Inicio / Dashboard:** `/dashboard` (resumen general, semáforos, alertas próximas).
- **Vehículos:** `/vehicles` (gestión del garaje, selector de activo, registro de vehículo).
- **Combustible:** `/fuel` (registro de tanqueadas, estadísticas de consumo).
- **Mantenimiento:** `/maintenance` (servicios realizados, próximas fechas e intervalos).
- **Gastos:** `/expenses` (registro rápido de egresos y clasificación).

---

## 6. Pilar 5: Sistema de Almacenamiento

El almacenamiento local se estructura en cuatro niveles complementarios:

### 1. Base de Datos Relacional (Drift + SQLite):
- **Motor:** `AppDatabase` único como singleton expuesto en Riverpod (`appDatabaseProvider`).
- **Integridad:**
  - Claves foráneas con borrado en cascada (`onDelete: KeyAction.cascade`).
  - Índices únicos compuestos (ej. `[user_id, plate]` en vehículos para evitar colisiones).
  - Los montos monetarios se almacenan obligatoriamente como **`INTEGER`** (unidad mínima monetaria, e.g. pesos colombianos sin decimales). Se prohíbe el uso de `REAL` en dinero para evitar errores de coma flotante.
  - Los enums de negocio se guardan como cadenas de texto (`TEXT`) para permitir adición de valores sin requerir migraciones complejas de esquema.

### 2. Almacenamiento Seguro (flutter_secure_storage):
- Guarda secretos del dispositivo:
  - Hash de PIN (calculado con SHA-256 sobre una sal aleatoria única generada por instalación).
  - Configuración de habilitación de autenticación biométrica.

### 3. Preferencias de Configuración (shared_preferences):
- Datos no sensibles de configuración de la app:
  - Ajustes de notificaciones locales (días de anticipación: 60, 30, 15, 7, 1 días).
  - Unidades de medida (km vs mi, galones vs litros).
  - Moneda preferida (`COP`, `USD`, etc.).
- El **vehículo activo** no vive aquí: se persiste en la columna `is_active` de la tabla `vehicles` (fuente única de verdad, consistente con Drift).

### 4. Almacenamiento de Archivos Físicos (`LocalStorageService` + path_provider):
- **Estructura en el almacenamiento interno del dispositivo (`app_documents/`):**
  ```
  app_documents/
  ├── vehicles/
  │   └── {vehicle_id}/
  │       ├── photos/             # Fotos del vehículo
  │       ├── documents/          # PDF o fotos de SOAT, Técnico-mecánica, Seguros
  │       └── receipts/           # Fotos de facturas de combustible o mantenimiento
  └── backups/                    # Archivos de copia de seguridad generados (.autoaldia / .sqlite)
  ```
- **Limpieza en Cascada Física:** Al eliminar un vehículo de la base de datos, el servicio borra recursivamente el directorio físico `vehicles/{vehicle_id}/` para no dejar archivos huérfanos ocupando almacenamiento.

---

## 7. Identidad Visual y Estados (Semáforo)

Para cumplir con la sección 52 y 53 del requerimiento:
- **Azul Principal (`#1565C0`):** Identidad, barras de herramientas, botones primarios.
- **Blanco / Gris (`#F8F9FA`, `#757575`):** Fondos limpios y textos secundarios.
- **Semáforo de Estados del Vehículo:**
  - **Verde (`#2E7D32`):** Al día / Todo correcto.
  - **Amarillo / Ámbar (`#F57F17`):** Próximo a vencer / Advertencia.
  - **Rojo (`#C62828`):** Vencido / Requiere atención inmediata.
  - **Gris (`#9E9E9E`):** Información histórica o inactiva.