/// Sistema central de errores de AutoAlDía.
///
/// Decisión: toda falla de infraestructura (base de datos, archivos, seguridad)
/// se convierte en un [AppFailure] antes de llegar a la UI. La UI solo muestra
/// [AppFailure.message]: un texto claro y amigable, nunca stack traces ni
/// errores técnicos crudos.
library;

/// Falla raíz de la aplicación.
sealed class AppFailure implements Exception {
  const AppFailure(this.message, {this.cause});

  /// Mensaje orientado al usuario final, en español.
  final String message;

  /// Error original que originó la falla (para depuración, no se muestra).
  final Object? cause;

  @override
  String toString() => message;
}

/// Fallas relacionadas con la base de datos local (Drift/SQLite).
class DatabaseFailure extends AppFailure {
  const DatabaseFailure(super.message, {super.cause});
}

/// Fallas al leer o escribir archivos en el almacenamiento local.
class StorageFailure extends AppFailure {
  const StorageFailure(super.message, {super.cause});
}

/// Fallas de seguridad: PIN, biometría o almacenamiento seguro.
class SecurityFailure extends AppFailure {
  const SecurityFailure(super.message, {super.cause});
}

/// Datos inválidos detectados por reglas de validación de dominio.
class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message, {super.cause});
}

/// Entidad buscada que no existe.
class NotFoundFailure extends AppFailure {
  const NotFoundFailure(super.message, {super.cause});
}

/// Falla que no pudo clasificarse; último recurso.
class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message, {super.cause});
}