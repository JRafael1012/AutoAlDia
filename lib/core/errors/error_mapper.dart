import 'dart:io';

import 'package:flutter/services.dart';

import 'app_failure.dart';

/// Convierte cualquier error lanzado en un [AppFailure] con mensaje amigable.
///
/// Garantiza que las operaciones de base de datos, archivos o seguridad nunca
/// terminen en silencio ni expongan detalles técnicos al usuario final.
AppFailure mapError(Object error, {String? fallbackMessage}) {
  if (error is AppFailure) {
    return error;
  }
  if (error is PlatformException) {
    return SecurityFailure(
      'No se pudo operar el almacenamiento de seguridad del dispositivo.',
      cause: error,
    );
  }
  if (error is FileSystemException) {
    return StorageFailure(
      'No se pudo acceder a los archivos de la aplicación.',
      cause: error,
    );
  }
  if (error is FormatException) {
    return ValidationFailure(
      'Los datos ingresados no tienen el formato esperado.',
      cause: error,
    );
  }
  return UnexpectedFailure(
    fallbackMessage ?? 'Ocurrió un error inesperado. Inténtalo de nuevo.',
    cause: error,
  );
}