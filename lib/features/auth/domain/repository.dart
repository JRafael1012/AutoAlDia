import 'models/user_profile.dart';

/// Interfaz abstracta del repositorio de perfil local (auth).
///
/// `domain/` no depende de Drift: la implementación concreta vive en `data/`.
abstract interface class AuthRepository {
  /// Devuelve el perfil del usuario o `null` si aún no se ha creado
  /// (una sola fila por instalación en el MVP).
  Future<UserProfile?> getProfile();

  /// Crea el perfil local. Si ya existe uno, lanza un error de validación
  /// (no se permite duplicar el perfil).
  Future<UserProfile> createProfile({
    required String name,
    String? email,
    String? phone,
  });

  /// Actualiza campos del perfil existente.
  Future<UserProfile> updateProfile({
    required int id,
    String? name,
    String? email,
    String? phone,
  });

  /// Elimina el perfil y todos sus datos (usado en respaldo/restauración).
  Future<void> deleteProfile(int id);
}