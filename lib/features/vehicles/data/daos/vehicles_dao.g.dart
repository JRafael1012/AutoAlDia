// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_dao.dart';

// ignore_for_file: type=lint
mixin _$VehiclesDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  VehiclesDaoManager get managers => VehiclesDaoManager(this);
}

class VehiclesDaoManager {
  final _$VehiclesDaoMixin _db;
  VehiclesDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
}
