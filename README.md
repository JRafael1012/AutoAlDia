# AutoAlDía

> **"Todo tu vehículo, siempre al día."**

**AutoAlDía** es una aplicación móvil diseñada para la administración integral, organizada y centralizada de uno o varios vehículos desde un único dispositivo.

El proyecto está concebido bajo el principio **Offline-First (100% local)**: almacena y gestiona toda la información (vehículos, tanqueadas, mantenimientos, gastos, pólizas de seguro e impuestos) directamente en el dispositivo móvil sin depender de conexión a Internet ni de servidores externos.

---

## 🚗 Características Principales (MVP)

1. **Gestión de Garaje y Vehículos:**
   - Registro de múltiples vehículos (marca, modelo, año, placa, odómetro, tipo de combustible, foto).
   - Selector de **Vehículo Activo** que sincroniza instantáneamente el Dashboard y los registros.
2. **Control de Combustible y Rendimiento:**
   - Registro de tanqueadas (litros/galones, costo total, odómetro, estación).
   - Cálculos automáticos de rendimiento (km/galón, costo por kilómetro).
3. **Mantenimiento Preventivo y Correctivo:**
   - Historial de servicios mecánicos, facturas y talleres.
   - Catálogo de servicios con intervalos configurables (por kilometraje o meses) y alertas preventivas.
4. **Documentos y Vencimientos:**
   - Control de SOAT, Revisión Técnico-mecánica, Seguros e Impuestos vehiculares.
   - Semáforo visual: **Verde** (al día), **Amarillo** (próximo a vencer) y **Rojo** (vencido).
5. **Gastos Generales:**
   - Registro y clasificación de peajes, lavados, parqueaderos y repuestos.
6. **Seguridad y Privacidad:**
   - Perfil de usuario local protegido opcionalmente por **PIN numérico** o **Biometría** (huella/Face ID).
   - Datos cifrados y protegidos en el dispositivo (`flutter_secure_storage`).
7. **Copias de Seguridad:**
   - Exportación e importación de respaldos locales completos de la base de datos.

---

## 🛠️ Stack Tecnológico

- **Framework:** [Flutter](https://flutter.dev) (Dart ^3.11.4).
- **Gestión de Estado:** [Riverpod v3](https://riverpod.dev) con generación de código (`riverpod_generator`).
- **Base de Datos Local:** [Drift](https://drift.simonbinder.eu/) sobre SQLite nativo con claves foráneas e integridad referencial (`PRAGMA foreign_keys = ON`).
- **Navegación:** [GoRouter](https://pub.dev/packages/go_router) con redirecciones reactivas de autenticación y shell persistente.
- **Gráficos:** `fl_chart`.
- **Almacenamiento Físico:** `path_provider` con organización de archivos por vehículo y borrado en cascada física.
- **Seguridad:** `flutter_secure_storage` (PIN hasheado con SHA-256 + salt) y `local_auth` (biometría).
- **Localización:** `flutter_localizations` e `intl` configurados en español (`es_CO`).

---

## 📂 Arquitectura del Proyecto

El código sigue una arquitectura **Clean Architecture + Feature-First**:

```
lib/
├── core/                  # Componentes y servicios transversales
│   ├── constants/         # Convenciones monetarias (enteros COP) y unidades
│   ├── database/          # AppDatabase (Drift), tablas transversales
│   ├── errors/            # AppFailure y excepciones amigables
│   ├── notifications/     # Servicio de alertas locales
│   ├── router/            # GoRouter, rutas y ShellScaffold
│   ├── security/          # PIN seguro y biometría
│   ├── storage/           # LocalStorageService (fotos y documentos)
│   ├── theme/             # Paleta institucional, semáforo y AppTheme
│   └── utils/             # Formateadores de fechas y moneda
├── features/              # Módulos de negocio independientes
│   ├── auth/              # Perfil local y pantallas de bloqueo
│   ├── vehicles/          # Garaje, vehículo activo y repositorio
│   ├── dashboard/         # Resumen y métricas del vehículo
│   ├── fuel/              # Tanqueadas y cálculos de consumo
│   ├── maintenance/       # Servicios mecánicos y catálogo
│   ├── expenses/          # Gastos generales clasificados
│   ├── documents/         # SOAT, RTM, pólizas e impuestos
│   ├── alerts/            # Centro de alertas
│   ├── reports/           # Estadísticas y gráficos
│   └── backups/           # Respaldos locales
└── shared/                # Componentes y widgets compartidos
    ├── widgets/           # StatusBadge, AppCard, StatItem, AppButton, AppTextField
    └── models/            # Enums y modelos globales
```

---

## 🚀 Cómo Ejecutar el Proyecto

### Requisitos Previos:
- Flutter SDK instalado (versión compatible con Dart ^3.11.4).
- Dispositivo Android o emulador configurado.

### Pasos:

1. **Clonar el repositorio:**
   ```bash
   git clone <url-del-repositorio>
   cd AutoAlDia
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Generar código de Drift y Riverpod (si es necesario):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Ejecutar el análisis estático:**
   ```bash
   flutter analyze
   ```

5. **Ejecutar las pruebas unitarias y de integración:**
   ```bash
   flutter test
   ```

6. **Iniciar la aplicación:**
   ```bash
   flutter run
   ```

---

## 📄 Documentación Técnica Adicional

- [ARQUITECTURA.md](ARQUITECTURA.md): Especificación detallada de arquitectura, capas y gestión de estado.
- [BASE_DE_DATOS.md](BASE_DE_DATOS.md): Diagrama ER, diccionario de tablas, índices y claves foráneas.
- [DISENO.md](DISENO.md): Guía de estilos, wireframes de pantallas y Design System.
- [DESARROLLO.md](DESARROLLO.md): Cronograma por etapas, dependencias y criterios de aceptación.
