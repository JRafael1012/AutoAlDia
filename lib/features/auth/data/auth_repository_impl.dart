import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/errors/app_failure.dart';
import '../domain/models/user_profile.dart';
import '../domain/repository.dart';
import 'daos/auth_dao.dart';

/// Implementación del repositorio de perfil sobre Drift.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._db);

  final AppDatabase _db;
  late final AuthDao _dao = AuthDao(_db);

  @override
  Future<UserProfile?> getProfile() async {
    try {
      final row = await _dao.getProfile();
      return row?.toProfile();
    } catch (e) {
      throw const DatabaseFailure(
        'No se pudo leer el perfil del dispositivo.',
      );
    }
  }

  @override
  Future<UserProfile> createProfile({
    required String name,
    String? email,
    String? phone,
  }) async {
    try {
      final existing = await _dao.getProfile();
      if (existing != null) {
        // Decisión: perfil único por instalación. Se actualiza en lugar de
        // duplicar para no perder datos si la UI llama dos veces.
        return (await updateProfile(
          id: existing.id,
          name: name,
          email: email,
          phone: phone,
        ));
      }
      final id = await _dao.insertProfile(
        UsersCompanion.insert(
          name: name.trim(),
          email: Value(email?.trim()),
          phone: Value(phone?.trim()),
        ),
      );
      final row = await _dao.getUserById(id);
      if (row == null) {
        throw const NotFoundFailure('El perfil no se creó correctamente.');
      }
      return row.toProfile();
    } on AppFailure {
      rethrow;
    } catch (e) {
      throw const DatabaseFailure(
        'No se pudo guardar el perfil. Intenta de nuevo.',
      );
    }
  }

  @override
  Future<UserProfile> updateProfile({
    required int id,
    String? name,
    String? email,
    String? phone,
  }) async {
    try {
      final entry = UsersCompanion(
        id: Value(id),
        name: name != null ? Value(name.trim()) : const Value.absent(),
        email: Value(email?.trim()),
        phone: Value(phone?.trim()),
      );
      await _dao.updateProfile(entry);
      final row = await _dao.getUserById(id);
      if (row == null) {
        throw const NotFoundFailure('El perfil ya no existe.');
      }
      return row.toProfile();
    } on AppFailure {
      rethrow;
    } catch (e) {
      throw const DatabaseFailure(
        'No se pudo actualizar el perfil. Intenta de nuevo.',
      );
    }
  }

  @override
  Future<void> deleteProfile(int id) async {
    try {
      await _dao.deleteProfile(id);
    } catch (e) {
      throw const DatabaseFailure(
        'No se pudo eliminar el perfil.',
      );
    }
  }
}

extension on User {
  UserProfile toProfile() {
    return UserProfile(
      id: id,
      name: name,
      email: email,
      phone: phone,
      currency: currency,
      createdAt: createdAt,
    );
  }
}