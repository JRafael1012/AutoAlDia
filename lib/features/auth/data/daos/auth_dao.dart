import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/users_table.dart';

part 'auth_dao.g.dart';

/// consultas de Drift para la tabla `users`.
@DriftAccessor(tables: [Users])
class AuthDao extends DatabaseAccessor<AppDatabase> with _$AuthDaoMixin {
  AuthDao(super.db);

  /// Una sola fila (perfil único por instalación).
  Future<User?> getProfile() {
    return (select(users)..limit(1)).getSingleOrNull();
  }

  Future<User?> getUserById(int id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertProfile(UsersCompanion entry) {
    return into(users).insert(entry);
  }

  Future<int> updateProfile(UsersCompanion entry) {
    return (update(users)..where((u) => u.id.equals(entry.id.value))).write(entry);
  }

  Future<int> deleteProfile(int id) {
    return (delete(users)..where((u) => u.id.equals(id))).go();
  }
}