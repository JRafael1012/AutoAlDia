import 'models/user_profile.dart';

/// Interfaz abstracta del repositorio de perfil local (auth).
///
/// `domain/` no depende de Drift: la implementación concreta vive en `data/`.
abstract interface class AuthRepository {
  /// Devuelve el perfil del usuario o `null` si aún no se ha creado
  /// (una sola fila por instalación en el MVP).
  Future<UserProfile?> getProfile();

  /// Crea el perfil local. Como solo puede existir un perfil por instalación,
  /// si ya existe uno lo actualiza (upsert) con los datos enviados en lugar de
  /// duplicarlo; nunca devuelve un error de duplicado.
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