# SISTEMA DE DISEÑO E INTERFACES — AutoAlDía

Este documento define la especificación visual y de experiencia de usuario de **AutoAlDía**, conforme a las secciones 51, 52, 53 y a la subsección **Diseño** de la Sección 68 del requerimiento:
- Wireframes y flujos.
- Pantallas del MVP.
- Navegación.
- Componentes del Design System.
- Colores y Semáforo de estados.
- Tipografía.
- Iconografía.
- Modo claro / modo oscuro.

---

## 1. Identidad Visual y Paleta de Colores

AutoAlDía utiliza una paleta enfocada en transmitir confiabilidad, orden y claridad:
- **Azul Institucional (`#1565C0`):** Color de marca principal. Aplica en AppBar, botones de acción primaria (`FilledButton`), indicadores activos de navegación y destacados.
- **Superficies Claras (`#FFFFFF`, `#F8F9FA`):** Fondos limpios para asegurar contraste con textos y tarjetas.
- **Superficies Oscuras (`#121212`, `#1E1E1E`):** Fondo y tarjetas en modo oscuro para ahorro de batería y confort visual nocturno.

### Semáforo de Estados del Vehículo (Secciones 52 y 53):
| Color | Código Hex | Estado | Significado en AutoAlDía |
|---|---|---|---|
| **Verde** | `#2E7D32` | **Al día** | Documentación vigente, mantenimientos al día, sin alertas pendientes (> 30 días o > 1.000 km). |
| **Amarillo / Ámbar** | `#F57F17` | **Próximo a vencer** | Documento o mantenimiento próximo a expirar (≤ 30 días o ≤ 500 km). Requiere atención programada. |
| **Rojo** | `#C62828` | **Vencido** | SOAT o técnico-mecánica vencidos, mantenimiento sobrepasado o cuota retrasada. Requiere acción inmediata. |
| **Gris** | `#9E9E9E` | **Histórico / Inactivo** | Vehículo vendido, registros anteriores o pólizas vencidas archivadas. |

---

## 2. Tipografía e Iconografía

### Escala Tipográfica (Material 3):
- **Display Large / Medium:** 28–32sp, SemiBold. Para totales destacados en Dashboard (ej. `$ 1.250.000`).
- **Title Large / Medium:** 18–22sp, Bold. Títulos de pantalla y nombres de vehículos (ej. `Mazda 3 • ABC123`).
- **Body Large / Medium:** 14–16sp, Regular. Textos descriptivos, valores de formularios y filas de lista.
- **Label Medium / Small:** 11–12sp, Medium. Subtítulos, badges de estado y pies de métricas (ej. `km/gal`).

### Catálogo de Iconos Oficiales:
- **Navegación Principal:**
  - Inicio / Dashboard: `Icons.dashboard_outlined` / `Icons.dashboard`
  - Garaje / Vehículos: `Icons.directions_car_outlined` / `Icons.directions_car`
  - Combustible: `Icons.local_gas_station_outlined` / `Icons.local_gas_station`
  - Mantenimiento: `Icons.build_outlined` / `Icons.build`
  - Gastos: `Icons.attach_money_outlined` / `Icons.attach_money`
- **Módulos Complementarios:**
  - Documentos / Vencimientos: `Icons.folder_outlined` / `Icons.description_outlined`
  - Alertas / Notificaciones: `Icons.notifications_none` / `Icons.notifications_active`
  - Reportes: `Icons.bar_chart_outlined`
  - Configuración: `Icons.settings_outlined`
  - Seguridad / PIN: `Icons.lock_outline` / `Icons.fingerprint`

---

## 3. Wireframes y Especificación de Pantallas del MVP

### 3.1. Pantalla de Bienvenida / Configuración Inicial (`/profile-setup`)
- **Propósito:** Registro rápido del usuario local la primera vez que abre la app.
- **Elementos:**
  - Logo / icono de auto con el título "AutoAlDía".
  - Slogan: *"Todo tu vehículo, siempre al día."*
  - Campo: Nombre del propietario (obligatorio).
  - Campo: Correo electrónico (opcional).
  - Switch: ¿Deseas proteger tu app con PIN?
    - Si se activa: Campo PIN (4 a 6 dígitos), Confirmar PIN, Switch Biometría (si el dispositivo soporta huella/rostro).
  - Botón principal: "Empezar".

### 3.2. Pantalla de Bloqueo por PIN (`/pin-lock`)
- **Propósito:** Protección de acceso en cada apertura de la aplicación si el PIN está configurado.
- **Elementos:**
  - Candado de seguridad.
  - Título: "AutoAlDía está bloqueado".
  - Input centrado para PIN numérico.
  - Botón: "Desbloquear".
  - Botón de acceso biométrico: "Usar huella o rostro" (si está habilitado).

### 3.3. Dashboard Principal (`/dashboard`)
- **Propósito:** Vista ejecutiva y centro de control del vehículo activo.
- **Wireframe conceptual:**
  ```
  ┌──────────────────────────────────────────────┐
  │ AutoAlDía                    [🔔 3]   [⚙️]   │
  │ Mazda 3 • ABC123  ▼                         │
  ├──────────────────────────────────────────────┤
  │ ┌──────────────────────────────────────────┐ │
  │ │ 🚗 Mazda 3 (2022)          [● Al día]    │ │
  │ │ Odómetro: 45.230 km                      │ │
  │ │ Gasto este mes: $ 350.000 COP            │ │
  │ └──────────────────────────────────────────┘ │
  │                                              │
  │ Acciones Rápidas:                            │
  │ [ + Tanquear ]  [ + Mantenimiento ]  [ + Gasto ]
  │                                              │
  │ Próximos Vencimientos:                       │
  │ ┌──────────────────────────────────────────┐ │
  │ │ 🟢 SOAT: Vence en 180 días               │ │
  │ │ 🟡 Cambio Aceite: Faltan 450 km          │ │
  │ │ 🔴 Técnico-mecánica: Vence en 5 días     │ │
  │ └──────────────────────────────────────────┘ │
  │                                              │
  │ Resumen Financiero del Mes:                  │
  │ • Combustible: $ 220.000                     │
  │ • Peajes y Otros: $ 130.000                  │
  └──────────────────────────────────────────────┘
  ```

### 3.4. Garaje de Vehículos (`/vehicles`)
- **Propósito:** Lista de autos/motos administrados con opción de alternar vehículo activo y botón flotante (+) para registrar nuevo vehículo.
- **Elementos por tarjeta:**
  - Fotografía o avatar por tipo de combustible/vehículo.
  - Marca, Modelo, Año y Placa.
  - Odómetro actual.
  - Chip "Vehículo Activo" (con botón para activar otro vehículo).
  - Menú de opciones (Editar datos, Registrar foto, Eliminar).

### 3.5. Módulo de Combustible (`/fuel`)
- **Propósito:** Bitácora de tanqueadas y análisis de consumo.
- **Elementos:**
  - KPI superior: Rendimiento promedio (km/galón o km/litro) y Costo por kilómetro recorrido.
  - Lista cronológica de registros (Fecha, Estación, Litros/Galones, Total pagado, Odómetro).
  - Indicador visual de "Tanque Lleno" para los registros de referencia.
  - Botón flotante (+): Formulario de tanqueada con cálculo automático de costo total (`litros * precio`).

### 3.6. Módulo de Mantenimiento (`/maintenance`)
- **Propósito:** Control preventivo y correctivo.
- **Elementos:**
  - Pestaña 1: Próximos servicios (ordenados por fecha o km más próximo a cumplirse con semáforo Verde/Amarillo/Rojo).
  - Pestaña 2: Historial de servicios realizados (con taller, costo, factura y notas).
  - Pestaña 3: Catálogo preventivo configurable (intervalos en km y meses).

### 3.7. Módulo de Gastos (`/expenses`)
- **Propósito:** Registro rápido de egresos generales.
- **Elementos:**
  - Desglose por categorías: Peaje, Parqueadero, Lavado, Repuestos, Multas, Otros.
  - Filtro mensual y suma acumulada.
  - Formulario de nuevo gasto con fecha, categoría, valor y notas.

### 3.8. Documentos y Vencimientos (`/documents`)
- **Propósito:** Expedición y control de SOAT, RTM, Seguros e Impuestos.
- **Elementos:**
  - Tarjetas dedicadas por tipo de documento legal.
  - Fecha de expedición, fecha de vencimiento y días restantes.
  - Semáforo automático: Verde (>30 días), Amarillo (≤30 días), Rojo (vencido).
  - Adjunto: Visualización de foto/PDF de la póliza o certificado.

### 3.9. Centro de Alertas (`/alerts`)
- **Propósito:** Listado unificado de recordatorios locales clasificados por vencidos, próximos y al día.

### 3.10. Configuración (`/settings`)
- **Propósito:** Perfil de usuario, ajustes de seguridad (PIN/biometría), anticipación de notificaciones (60, 30, 15, 7, 1 días), unidades de medida y copias de seguridad.

---

## 4. Componentes Compartidos (Design System)

Para mantener una interfaz consistente en todas las pantallas se definen los siguientes componentes base:

1. **`StatusBadge`:** Chip indicador con semáforo (Verde, Amarillo, Rojo, Gris) y texto descriptivo.
2. **`AppCard`:** Tarjeta con borde sutil, fondo adaptativo y esquinas redondeadas (12px).
3. **`StatItem`:** Visualizador de métricas clave (etiqueta superior, valor destacado, icono temático).
4. **`AppButton`:** Botón primario y secundario con estado de carga integrado (`isLoading`).
5. **`AppTextField`:** Input de formulario unificado con bordes suaves, iconos de ayuda y manejo de errores.

---

## 5. Modo Claro y Modo Oscuro

- **Modo Claro:**
  - Fondo de aplicación: `#F8F9FA`
  - Fondo de tarjetas y AppBar: `#FFFFFF`
  - Texto principal: `#212121`
  - Bordes y separadores: `#E0E0E0`
- **Modo Oscuro:**
  - Fondo de aplicación: `#121212`
  - Fondo de tarjetas y AppBar: `#1E1E1E`
  - Texto principal: `#FFFFFF`
  - Bordes y separadores: `rgba(255, 255, 255, 0.12)`
- **Soporte de Tema:** Configurado en `AppTheme` conmutando de forma reactiva según la preferencia del sistema o la configuración de usuario.
