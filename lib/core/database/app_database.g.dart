// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('COP'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    phone,
    currency,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String? email;
  final String? phone;

  /// Moneda activa del usuario. Unidad mínima = 1 peso (COP) en el MVP.
  final String currency;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    required this.currency,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['currency'] = Variable<String>(currency);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      currency: Value(currency),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      currency: serializer.fromJson<String>(json['currency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'currency': serializer.toJson<String>(currency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    String? currency,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    currency: currency ?? this.currency,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      currency: data.currency.present ? data.currency.value : this.currency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, phone, currency, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String> currency;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? currency,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String>? currency,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plateMeta = const VerificationMeta('plate');
  @override
  late final GeneratedColumn<String> plate = GeneratedColumn<String>(
    'plate',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<double> odometerKm = GeneratedColumn<double>(
    'odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('activo'),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    brand,
    model,
    year,
    plate,
    odometerKm,
    fuelType,
    status,
    photoPath,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('plate')) {
      context.handle(
        _plateMeta,
        plate.isAcceptableOrUnknown(data['plate']!, _plateMeta),
      );
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      plate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate'],
      ),
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_km'],
      )!,
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final int id;
  final int userId;
  final String brand;
  final String model;
  final int? year;
  final String? plate;

  /// Kilometraje actual del vehículo. No es monto: admite decimales.
  final double odometerKm;

  /// gasolina | diesel | electrico | hibrido. TEXT libre validado por la UI.
  final String fuelType;

  /// activo | inactivo | vendido.
  final String status;

  /// Ruta relativa a la foto dentro de `app_documents/vehicles/{id}/photos/`.
  final String? photoPath;

  /// Vehículo seleccionado por el usuario (para módulos como combustible/gastos).
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Vehicle({
    required this.id,
    required this.userId,
    required this.brand,
    required this.model,
    this.year,
    this.plate,
    required this.odometerKm,
    required this.fuelType,
    required this.status,
    this.photoPath,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['brand'] = Variable<String>(brand);
    map['model'] = Variable<String>(model);
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || plate != null) {
      map['plate'] = Variable<String>(plate);
    }
    map['odometer_km'] = Variable<double>(odometerKm);
    map['fuel_type'] = Variable<String>(fuelType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      userId: Value(userId),
      brand: Value(brand),
      model: Value(model),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      plate: plate == null && nullToAbsent
          ? const Value.absent()
          : Value(plate),
      odometerKm: Value(odometerKm),
      fuelType: Value(fuelType),
      status: Value(status),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      brand: serializer.fromJson<String>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int?>(json['year']),
      plate: serializer.fromJson<String?>(json['plate']),
      odometerKm: serializer.fromJson<double>(json['odometerKm']),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      status: serializer.fromJson<String>(json['status']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'brand': serializer.toJson<String>(brand),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int?>(year),
      'plate': serializer.toJson<String?>(plate),
      'odometerKm': serializer.toJson<double>(odometerKm),
      'fuelType': serializer.toJson<String>(fuelType),
      'status': serializer.toJson<String>(status),
      'photoPath': serializer.toJson<String?>(photoPath),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Vehicle copyWith({
    int? id,
    int? userId,
    String? brand,
    String? model,
    Value<int?> year = const Value.absent(),
    Value<String?> plate = const Value.absent(),
    double? odometerKm,
    String? fuelType,
    String? status,
    Value<String?> photoPath = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Vehicle(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    year: year.present ? year.value : this.year,
    plate: plate.present ? plate.value : this.plate,
    odometerKm: odometerKm ?? this.odometerKm,
    fuelType: fuelType ?? this.fuelType,
    status: status ?? this.status,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      plate: data.plate.present ? data.plate.value : this.plate,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      status: data.status.present ? data.status.value : this.status,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('plate: $plate, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('fuelType: $fuelType, ')
          ..write('status: $status, ')
          ..write('photoPath: $photoPath, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    brand,
    model,
    year,
    plate,
    odometerKm,
    fuelType,
    status,
    photoPath,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.year == this.year &&
          other.plate == this.plate &&
          other.odometerKm == this.odometerKm &&
          other.fuelType == this.fuelType &&
          other.status == this.status &&
          other.photoPath == this.photoPath &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> brand;
  final Value<String> model;
  final Value<int?> year;
  final Value<String?> plate;
  final Value<double> odometerKm;
  final Value<String> fuelType;
  final Value<String> status;
  final Value<String?> photoPath;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.plate = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.status = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String brand,
    required String model,
    this.year = const Value.absent(),
    this.plate = const Value.absent(),
    required double odometerKm,
    required String fuelType,
    this.status = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userId = Value(userId),
       brand = Value(brand),
       model = Value(model),
       odometerKm = Value(odometerKm),
       fuelType = Value(fuelType);
  static Insertable<Vehicle> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<int>? year,
    Expression<String>? plate,
    Expression<double>? odometerKm,
    Expression<String>? fuelType,
    Expression<String>? status,
    Expression<String>? photoPath,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (plate != null) 'plate': plate,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (fuelType != null) 'fuel_type': fuelType,
      if (status != null) 'status': status,
      if (photoPath != null) 'photo_path': photoPath,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VehiclesCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? brand,
    Value<String>? model,
    Value<int?>? year,
    Value<String?>? plate,
    Value<double>? odometerKm,
    Value<String>? fuelType,
    Value<String>? status,
    Value<String?>? photoPath,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      odometerKm: odometerKm ?? this.odometerKm,
      fuelType: fuelType ?? this.fuelType,
      status: status ?? this.status,
      photoPath: photoPath ?? this.photoPath,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (plate.present) {
      map['plate'] = Variable<String>(plate.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<double>(odometerKm.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('plate: $plate, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('fuelType: $fuelType, ')
          ..write('status: $status, ')
          ..write('photoPath: $photoPath, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FuelRecordsTable extends FuelRecords
    with TableInfo<$FuelRecordsTable, FuelRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<double> odometerKm = GeneratedColumn<double>(
    'odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litersMeta = const VerificationMeta('liters');
  @override
  late final GeneratedColumn<double> liters = GeneratedColumn<double>(
    'liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<int> unitPrice = GeneratedColumn<int>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<int> totalCost = GeneratedColumn<int>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFullTankMeta = const VerificationMeta(
    'isFullTank',
  );
  @override
  late final GeneratedColumn<bool> isFullTank = GeneratedColumn<bool>(
    'is_full_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_full_tank" IN (0, 1))',
    ),
  );
  static const VerificationMeta _stationMeta = const VerificationMeta(
    'station',
  );
  @override
  late final GeneratedColumn<String> station = GeneratedColumn<String>(
    'station',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    date,
    odometerKm,
    liters,
    unitPrice,
    totalCost,
    isFullTank,
    station,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('liters')) {
      context.handle(
        _litersMeta,
        liters.isAcceptableOrUnknown(data['liters']!, _litersMeta),
      );
    } else if (isInserting) {
      context.missing(_litersMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('is_full_tank')) {
      context.handle(
        _isFullTankMeta,
        isFullTank.isAcceptableOrUnknown(
          data['is_full_tank']!,
          _isFullTankMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isFullTankMeta);
    }
    if (data.containsKey('station')) {
      context.handle(
        _stationMeta,
        station.isAcceptableOrUnknown(data['station']!, _stationMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_km'],
      )!,
      liters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}liters'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cost'],
      )!,
      isFullTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_full_tank'],
      )!,
      station: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FuelRecordsTable createAlias(String alias) {
    return $FuelRecordsTable(attachedDatabase, alias);
  }
}

class FuelRecord extends DataClass implements Insertable<FuelRecord> {
  final int id;
  final int vehicleId;
  final DateTime date;
  final double odometerKm;
  final double liters;

  /// Precio por litro. Decisión: montos como enteros (unidad mínima). Ver
  /// `core/constants/money_convention.md`. COP = pesos sin decimales.
  final int unitPrice;

  /// Costo total de la carga (litros x precio, redondeado al entero).
  final int totalCost;

  /// true = tanque lleno (referencia para el cálculo de consumo).
  final bool isFullTank;
  final String? station;
  final String? notes;
  const FuelRecord({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.odometerKm,
    required this.liters,
    required this.unitPrice,
    required this.totalCost,
    required this.isFullTank,
    this.station,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['date'] = Variable<DateTime>(date);
    map['odometer_km'] = Variable<double>(odometerKm);
    map['liters'] = Variable<double>(liters);
    map['unit_price'] = Variable<int>(unitPrice);
    map['total_cost'] = Variable<int>(totalCost);
    map['is_full_tank'] = Variable<bool>(isFullTank);
    if (!nullToAbsent || station != null) {
      map['station'] = Variable<String>(station);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FuelRecordsCompanion toCompanion(bool nullToAbsent) {
    return FuelRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      date: Value(date),
      odometerKm: Value(odometerKm),
      liters: Value(liters),
      unitPrice: Value(unitPrice),
      totalCost: Value(totalCost),
      isFullTank: Value(isFullTank),
      station: station == null && nullToAbsent
          ? const Value.absent()
          : Value(station),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FuelRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelRecord(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometerKm: serializer.fromJson<double>(json['odometerKm']),
      liters: serializer.fromJson<double>(json['liters']),
      unitPrice: serializer.fromJson<int>(json['unitPrice']),
      totalCost: serializer.fromJson<int>(json['totalCost']),
      isFullTank: serializer.fromJson<bool>(json['isFullTank']),
      station: serializer.fromJson<String?>(json['station']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'date': serializer.toJson<DateTime>(date),
      'odometerKm': serializer.toJson<double>(odometerKm),
      'liters': serializer.toJson<double>(liters),
      'unitPrice': serializer.toJson<int>(unitPrice),
      'totalCost': serializer.toJson<int>(totalCost),
      'isFullTank': serializer.toJson<bool>(isFullTank),
      'station': serializer.toJson<String?>(station),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FuelRecord copyWith({
    int? id,
    int? vehicleId,
    DateTime? date,
    double? odometerKm,
    double? liters,
    int? unitPrice,
    int? totalCost,
    bool? isFullTank,
    Value<String?> station = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => FuelRecord(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    date: date ?? this.date,
    odometerKm: odometerKm ?? this.odometerKm,
    liters: liters ?? this.liters,
    unitPrice: unitPrice ?? this.unitPrice,
    totalCost: totalCost ?? this.totalCost,
    isFullTank: isFullTank ?? this.isFullTank,
    station: station.present ? station.value : this.station,
    notes: notes.present ? notes.value : this.notes,
  );
  FuelRecord copyWithCompanion(FuelRecordsCompanion data) {
    return FuelRecord(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      date: data.date.present ? data.date.value : this.date,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      liters: data.liters.present ? data.liters.value : this.liters,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      isFullTank: data.isFullTank.present
          ? data.isFullTank.value
          : this.isFullTank,
      station: data.station.present ? data.station.value : this.station,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelRecord(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('liters: $liters, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalCost: $totalCost, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('station: $station, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    date,
    odometerKm,
    liters,
    unitPrice,
    totalCost,
    isFullTank,
    station,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelRecord &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.date == this.date &&
          other.odometerKm == this.odometerKm &&
          other.liters == this.liters &&
          other.unitPrice == this.unitPrice &&
          other.totalCost == this.totalCost &&
          other.isFullTank == this.isFullTank &&
          other.station == this.station &&
          other.notes == this.notes);
}

class FuelRecordsCompanion extends UpdateCompanion<FuelRecord> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<DateTime> date;
  final Value<double> odometerKm;
  final Value<double> liters;
  final Value<int> unitPrice;
  final Value<int> totalCost;
  final Value<bool> isFullTank;
  final Value<String?> station;
  final Value<String?> notes;
  const FuelRecordsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.date = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.liters = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.isFullTank = const Value.absent(),
    this.station = const Value.absent(),
    this.notes = const Value.absent(),
  });
  FuelRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required DateTime date,
    required double odometerKm,
    required double liters,
    required int unitPrice,
    required int totalCost,
    required bool isFullTank,
    this.station = const Value.absent(),
    this.notes = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       date = Value(date),
       odometerKm = Value(odometerKm),
       liters = Value(liters),
       unitPrice = Value(unitPrice),
       totalCost = Value(totalCost),
       isFullTank = Value(isFullTank);
  static Insertable<FuelRecord> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<DateTime>? date,
    Expression<double>? odometerKm,
    Expression<double>? liters,
    Expression<int>? unitPrice,
    Expression<int>? totalCost,
    Expression<bool>? isFullTank,
    Expression<String>? station,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (date != null) 'date': date,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (liters != null) 'liters': liters,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalCost != null) 'total_cost': totalCost,
      if (isFullTank != null) 'is_full_tank': isFullTank,
      if (station != null) 'station': station,
      if (notes != null) 'notes': notes,
    });
  }

  FuelRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<DateTime>? date,
    Value<double>? odometerKm,
    Value<double>? liters,
    Value<int>? unitPrice,
    Value<int>? totalCost,
    Value<bool>? isFullTank,
    Value<String?>? station,
    Value<String?>? notes,
  }) {
    return FuelRecordsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      date: date ?? this.date,
      odometerKm: odometerKm ?? this.odometerKm,
      liters: liters ?? this.liters,
      unitPrice: unitPrice ?? this.unitPrice,
      totalCost: totalCost ?? this.totalCost,
      isFullTank: isFullTank ?? this.isFullTank,
      station: station ?? this.station,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<double>(odometerKm.value);
    }
    if (liters.present) {
      map['liters'] = Variable<double>(liters.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<int>(unitPrice.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<int>(totalCost.value);
    }
    if (isFullTank.present) {
      map['is_full_tank'] = Variable<bool>(isFullTank.value);
    }
    if (station.present) {
      map['station'] = Variable<String>(station.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelRecordsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('liters: $liters, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalCost: $totalCost, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('station: $station, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceTypesTable extends MaintenanceTypes
    with TableInfo<$MaintenanceTypesTable, MaintenanceType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _recommendedIntervalKmMeta =
      const VerificationMeta('recommendedIntervalKm');
  @override
  late final GeneratedColumn<double> recommendedIntervalKm =
      GeneratedColumn<double>(
        'recommended_interval_km',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _recommendedIntervalMonthsMeta =
      const VerificationMeta('recommendedIntervalMonths');
  @override
  late final GeneratedColumn<int> recommendedIntervalMonths =
      GeneratedColumn<int>(
        'recommended_interval_months',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    recommendedIntervalKm,
    recommendedIntervalMonths,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('recommended_interval_km')) {
      context.handle(
        _recommendedIntervalKmMeta,
        recommendedIntervalKm.isAcceptableOrUnknown(
          data['recommended_interval_km']!,
          _recommendedIntervalKmMeta,
        ),
      );
    }
    if (data.containsKey('recommended_interval_months')) {
      context.handle(
        _recommendedIntervalMonthsMeta,
        recommendedIntervalMonths.isAcceptableOrUnknown(
          data['recommended_interval_months']!,
          _recommendedIntervalMonthsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      recommendedIntervalKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}recommended_interval_km'],
      ),
      recommendedIntervalMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recommended_interval_months'],
      ),
    );
  }

  @override
  $MaintenanceTypesTable createAlias(String alias) {
    return $MaintenanceTypesTable(attachedDatabase, alias);
  }
}

class MaintenanceType extends DataClass implements Insertable<MaintenanceType> {
  final int id;
  final String name;

  /// Intervalo recomendado en km (opcional; depende del tipo).
  final double? recommendedIntervalKm;

  /// Intervalo recomendado en meses (opcional).
  final int? recommendedIntervalMonths;
  const MaintenanceType({
    required this.id,
    required this.name,
    this.recommendedIntervalKm,
    this.recommendedIntervalMonths,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || recommendedIntervalKm != null) {
      map['recommended_interval_km'] = Variable<double>(recommendedIntervalKm);
    }
    if (!nullToAbsent || recommendedIntervalMonths != null) {
      map['recommended_interval_months'] = Variable<int>(
        recommendedIntervalMonths,
      );
    }
    return map;
  }

  MaintenanceTypesCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceTypesCompanion(
      id: Value(id),
      name: Value(name),
      recommendedIntervalKm: recommendedIntervalKm == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedIntervalKm),
      recommendedIntervalMonths:
          recommendedIntervalMonths == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedIntervalMonths),
    );
  }

  factory MaintenanceType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      recommendedIntervalKm: serializer.fromJson<double?>(
        json['recommendedIntervalKm'],
      ),
      recommendedIntervalMonths: serializer.fromJson<int?>(
        json['recommendedIntervalMonths'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'recommendedIntervalKm': serializer.toJson<double?>(
        recommendedIntervalKm,
      ),
      'recommendedIntervalMonths': serializer.toJson<int?>(
        recommendedIntervalMonths,
      ),
    };
  }

  MaintenanceType copyWith({
    int? id,
    String? name,
    Value<double?> recommendedIntervalKm = const Value.absent(),
    Value<int?> recommendedIntervalMonths = const Value.absent(),
  }) => MaintenanceType(
    id: id ?? this.id,
    name: name ?? this.name,
    recommendedIntervalKm: recommendedIntervalKm.present
        ? recommendedIntervalKm.value
        : this.recommendedIntervalKm,
    recommendedIntervalMonths: recommendedIntervalMonths.present
        ? recommendedIntervalMonths.value
        : this.recommendedIntervalMonths,
  );
  MaintenanceType copyWithCompanion(MaintenanceTypesCompanion data) {
    return MaintenanceType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      recommendedIntervalKm: data.recommendedIntervalKm.present
          ? data.recommendedIntervalKm.value
          : this.recommendedIntervalKm,
      recommendedIntervalMonths: data.recommendedIntervalMonths.present
          ? data.recommendedIntervalMonths.value
          : this.recommendedIntervalMonths,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('recommendedIntervalKm: $recommendedIntervalKm, ')
          ..write('recommendedIntervalMonths: $recommendedIntervalMonths')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, recommendedIntervalKm, recommendedIntervalMonths);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceType &&
          other.id == this.id &&
          other.name == this.name &&
          other.recommendedIntervalKm == this.recommendedIntervalKm &&
          other.recommendedIntervalMonths == this.recommendedIntervalMonths);
}

class MaintenanceTypesCompanion extends UpdateCompanion<MaintenanceType> {
  final Value<int> id;
  final Value<String> name;
  final Value<double?> recommendedIntervalKm;
  final Value<int?> recommendedIntervalMonths;
  const MaintenanceTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.recommendedIntervalKm = const Value.absent(),
    this.recommendedIntervalMonths = const Value.absent(),
  });
  MaintenanceTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.recommendedIntervalKm = const Value.absent(),
    this.recommendedIntervalMonths = const Value.absent(),
  }) : name = Value(name);
  static Insertable<MaintenanceType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? recommendedIntervalKm,
    Expression<int>? recommendedIntervalMonths,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (recommendedIntervalKm != null)
        'recommended_interval_km': recommendedIntervalKm,
      if (recommendedIntervalMonths != null)
        'recommended_interval_months': recommendedIntervalMonths,
    });
  }

  MaintenanceTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double?>? recommendedIntervalKm,
    Value<int?>? recommendedIntervalMonths,
  }) {
    return MaintenanceTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      recommendedIntervalKm:
          recommendedIntervalKm ?? this.recommendedIntervalKm,
      recommendedIntervalMonths:
          recommendedIntervalMonths ?? this.recommendedIntervalMonths,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (recommendedIntervalKm.present) {
      map['recommended_interval_km'] = Variable<double>(
        recommendedIntervalKm.value,
      );
    }
    if (recommendedIntervalMonths.present) {
      map['recommended_interval_months'] = Variable<int>(
        recommendedIntervalMonths.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('recommendedIntervalKm: $recommendedIntervalKm, ')
          ..write('recommendedIntervalMonths: $recommendedIntervalMonths')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceTable extends Maintenance
    with TableInfo<$MaintenanceTable, MaintenanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES maintenance_types (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<double> odometerKm = GeneratedColumn<double>(
    'odometer_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueKmMeta = const VerificationMeta(
    'nextDueKm',
  );
  @override
  late final GeneratedColumn<double> nextDueKm = GeneratedColumn<double>(
    'next_due_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    typeId,
    date,
    odometerKm,
    title,
    cost,
    nextDueDate,
    nextDueKm,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    if (data.containsKey('next_due_km')) {
      context.handle(
        _nextDueKmMeta,
        nextDueKm.isAcceptableOrUnknown(data['next_due_km']!, _nextDueKmMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_km'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      )!,
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      ),
      nextDueKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}next_due_km'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MaintenanceTable createAlias(String alias) {
    return $MaintenanceTable(attachedDatabase, alias);
  }
}

class MaintenanceData extends DataClass implements Insertable<MaintenanceData> {
  final int id;
  final int vehicleId;

  /// Nullable: un mantenimiento puede no corresponder al catálogo.
  final int? typeId;
  final DateTime date;
  final double? odometerKm;
  final String title;

  /// Decisión: monto como entero (unidad mínima de la moneda).
  final int cost;

  /// Recordatorio por fecha (si se definió uno).
  final DateTime? nextDueDate;

  /// Recordatorio por kilometraje (si se definió uno).
  final double? nextDueKm;
  final String? notes;
  final DateTime createdAt;
  const MaintenanceData({
    required this.id,
    required this.vehicleId,
    this.typeId,
    required this.date,
    this.odometerKm,
    required this.title,
    required this.cost,
    this.nextDueDate,
    this.nextDueKm,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    if (!nullToAbsent || typeId != null) {
      map['type_id'] = Variable<int>(typeId);
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || odometerKm != null) {
      map['odometer_km'] = Variable<double>(odometerKm);
    }
    map['title'] = Variable<String>(title);
    map['cost'] = Variable<int>(cost);
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    if (!nullToAbsent || nextDueKm != null) {
      map['next_due_km'] = Variable<double>(nextDueKm);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaintenanceCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      typeId: typeId == null && nullToAbsent
          ? const Value.absent()
          : Value(typeId),
      date: Value(date),
      odometerKm: odometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(odometerKm),
      title: Value(title),
      cost: Value(cost),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
      nextDueKm: nextDueKm == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueKm),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory MaintenanceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceData(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      typeId: serializer.fromJson<int?>(json['typeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometerKm: serializer.fromJson<double?>(json['odometerKm']),
      title: serializer.fromJson<String>(json['title']),
      cost: serializer.fromJson<int>(json['cost']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
      nextDueKm: serializer.fromJson<double?>(json['nextDueKm']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'typeId': serializer.toJson<int?>(typeId),
      'date': serializer.toJson<DateTime>(date),
      'odometerKm': serializer.toJson<double?>(odometerKm),
      'title': serializer.toJson<String>(title),
      'cost': serializer.toJson<int>(cost),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
      'nextDueKm': serializer.toJson<double?>(nextDueKm),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaintenanceData copyWith({
    int? id,
    int? vehicleId,
    Value<int?> typeId = const Value.absent(),
    DateTime? date,
    Value<double?> odometerKm = const Value.absent(),
    String? title,
    int? cost,
    Value<DateTime?> nextDueDate = const Value.absent(),
    Value<double?> nextDueKm = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => MaintenanceData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    typeId: typeId.present ? typeId.value : this.typeId,
    date: date ?? this.date,
    odometerKm: odometerKm.present ? odometerKm.value : this.odometerKm,
    title: title ?? this.title,
    cost: cost ?? this.cost,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
    nextDueKm: nextDueKm.present ? nextDueKm.value : this.nextDueKm,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  MaintenanceData copyWithCompanion(MaintenanceCompanion data) {
    return MaintenanceData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      date: data.date.present ? data.date.value : this.date,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      title: data.title.present ? data.title.value : this.title,
      cost: data.cost.present ? data.cost.value : this.cost,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      nextDueKm: data.nextDueKm.present ? data.nextDueKm.value : this.nextDueKm,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('typeId: $typeId, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('title: $title, ')
          ..write('cost: $cost, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueKm: $nextDueKm, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    typeId,
    date,
    odometerKm,
    title,
    cost,
    nextDueDate,
    nextDueKm,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.typeId == this.typeId &&
          other.date == this.date &&
          other.odometerKm == this.odometerKm &&
          other.title == this.title &&
          other.cost == this.cost &&
          other.nextDueDate == this.nextDueDate &&
          other.nextDueKm == this.nextDueKm &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class MaintenanceCompanion extends UpdateCompanion<MaintenanceData> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<int?> typeId;
  final Value<DateTime> date;
  final Value<double?> odometerKm;
  final Value<String> title;
  final Value<int> cost;
  final Value<DateTime?> nextDueDate;
  final Value<double?> nextDueKm;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const MaintenanceCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.date = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.title = const Value.absent(),
    this.cost = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.nextDueKm = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MaintenanceCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    this.typeId = const Value.absent(),
    required DateTime date,
    this.odometerKm = const Value.absent(),
    required String title,
    required int cost,
    this.nextDueDate = const Value.absent(),
    this.nextDueKm = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       date = Value(date),
       title = Value(title),
       cost = Value(cost);
  static Insertable<MaintenanceData> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<int>? typeId,
    Expression<DateTime>? date,
    Expression<double>? odometerKm,
    Expression<String>? title,
    Expression<int>? cost,
    Expression<DateTime>? nextDueDate,
    Expression<double>? nextDueKm,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (typeId != null) 'type_id': typeId,
      if (date != null) 'date': date,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (title != null) 'title': title,
      if (cost != null) 'cost': cost,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (nextDueKm != null) 'next_due_km': nextDueKm,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MaintenanceCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<int?>? typeId,
    Value<DateTime>? date,
    Value<double?>? odometerKm,
    Value<String>? title,
    Value<int>? cost,
    Value<DateTime?>? nextDueDate,
    Value<double?>? nextDueKm,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return MaintenanceCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      typeId: typeId ?? this.typeId,
      date: date ?? this.date,
      odometerKm: odometerKm ?? this.odometerKm,
      title: title ?? this.title,
      cost: cost ?? this.cost,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      nextDueKm: nextDueKm ?? this.nextDueKm,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<double>(odometerKm.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (nextDueKm.present) {
      map['next_due_km'] = Variable<double>(nextDueKm.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('typeId: $typeId, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('title: $title, ')
          ..write('cost: $cost, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueKm: $nextDueKm, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    category,
    amount,
    date,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final int vehicleId;
  final String category;

  /// Decisión: monto como entero (unidad mínima de la moneda).
  final int amount;
  final DateTime date;
  final String? description;
  final DateTime createdAt;
  const Expense({
    required this.id,
    required this.vehicleId,
    required this.category,
    required this.amount,
    required this.date,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      category: Value(category),
      amount: Value(amount),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith({
    int? id,
    int? vehicleId,
    String? category,
    int? amount,
    DateTime? date,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => Expense(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    category,
    amount,
    date,
    description,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> category;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String category,
    required int amount,
    required DateTime date,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       category = Value(category),
       amount = Value(amount),
       date = Value(date);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? category,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? category,
    Value<int>? amount,
    Value<DateTime>? date,
    Value<String?>? description,
    Value<DateTime>? createdAt,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _docTypeMeta = const VerificationMeta(
    'docType',
  );
  @override
  late final GeneratedColumn<String> docType = GeneratedColumn<String>(
    'doc_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderDaysMeta = const VerificationMeta(
    'reminderDays',
  );
  @override
  late final GeneratedColumn<int> reminderDays = GeneratedColumn<int>(
    'reminder_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    docType,
    name,
    number,
    issueDate,
    expiryDate,
    filePath,
    reminderDays,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('doc_type')) {
      context.handle(
        _docTypeMeta,
        docType.isAcceptableOrUnknown(data['doc_type']!, _docTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_docTypeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expiryDateMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    }
    if (data.containsKey('reminder_days')) {
      context.handle(
        _reminderDaysMeta,
        reminderDays.isAcceptableOrUnknown(
          data['reminder_days']!,
          _reminderDaysMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      docType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doc_type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      ),
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      ),
      reminderDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_days'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final int id;
  final int vehicleId;
  final String docType;
  final String name;
  final String? number;
  final DateTime? issueDate;

  /// Fecha de vencimiento; base para las alertas de caducidad.
  final DateTime expiryDate;

  /// Ruta relativa al archivo dentro de `app_documents/documents/{id}/`.
  final String? filePath;

  /// Días de anticipación para la alerta de vencimiento.
  final int reminderDays;
  final DateTime createdAt;
  const Document({
    required this.id,
    required this.vehicleId,
    required this.docType,
    required this.name,
    this.number,
    this.issueDate,
    required this.expiryDate,
    this.filePath,
    required this.reminderDays,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['doc_type'] = Variable<String>(docType);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    if (!nullToAbsent || issueDate != null) {
      map['issue_date'] = Variable<DateTime>(issueDate);
    }
    map['expiry_date'] = Variable<DateTime>(expiryDate);
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    map['reminder_days'] = Variable<int>(reminderDays);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      docType: Value(docType),
      name: Value(name),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      issueDate: issueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(issueDate),
      expiryDate: Value(expiryDate),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      reminderDays: Value(reminderDays),
      createdAt: Value(createdAt),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      docType: serializer.fromJson<String>(json['docType']),
      name: serializer.fromJson<String>(json['name']),
      number: serializer.fromJson<String?>(json['number']),
      issueDate: serializer.fromJson<DateTime?>(json['issueDate']),
      expiryDate: serializer.fromJson<DateTime>(json['expiryDate']),
      filePath: serializer.fromJson<String?>(json['filePath']),
      reminderDays: serializer.fromJson<int>(json['reminderDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'docType': serializer.toJson<String>(docType),
      'name': serializer.toJson<String>(name),
      'number': serializer.toJson<String?>(number),
      'issueDate': serializer.toJson<DateTime?>(issueDate),
      'expiryDate': serializer.toJson<DateTime>(expiryDate),
      'filePath': serializer.toJson<String?>(filePath),
      'reminderDays': serializer.toJson<int>(reminderDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Document copyWith({
    int? id,
    int? vehicleId,
    String? docType,
    String? name,
    Value<String?> number = const Value.absent(),
    Value<DateTime?> issueDate = const Value.absent(),
    DateTime? expiryDate,
    Value<String?> filePath = const Value.absent(),
    int? reminderDays,
    DateTime? createdAt,
  }) => Document(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    docType: docType ?? this.docType,
    name: name ?? this.name,
    number: number.present ? number.value : this.number,
    issueDate: issueDate.present ? issueDate.value : this.issueDate,
    expiryDate: expiryDate ?? this.expiryDate,
    filePath: filePath.present ? filePath.value : this.filePath,
    reminderDays: reminderDays ?? this.reminderDays,
    createdAt: createdAt ?? this.createdAt,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      docType: data.docType.present ? data.docType.value : this.docType,
      name: data.name.present ? data.name.value : this.name,
      number: data.number.present ? data.number.value : this.number,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      reminderDays: data.reminderDays.present
          ? data.reminderDays.value
          : this.reminderDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('docType: $docType, ')
          ..write('name: $name, ')
          ..write('number: $number, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('filePath: $filePath, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    docType,
    name,
    number,
    issueDate,
    expiryDate,
    filePath,
    reminderDays,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.docType == this.docType &&
          other.name == this.name &&
          other.number == this.number &&
          other.issueDate == this.issueDate &&
          other.expiryDate == this.expiryDate &&
          other.filePath == this.filePath &&
          other.reminderDays == this.reminderDays &&
          other.createdAt == this.createdAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> docType;
  final Value<String> name;
  final Value<String?> number;
  final Value<DateTime?> issueDate;
  final Value<DateTime> expiryDate;
  final Value<String?> filePath;
  final Value<int> reminderDays;
  final Value<DateTime> createdAt;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.docType = const Value.absent(),
    this.name = const Value.absent(),
    this.number = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.filePath = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String docType,
    required String name,
    this.number = const Value.absent(),
    this.issueDate = const Value.absent(),
    required DateTime expiryDate,
    this.filePath = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       docType = Value(docType),
       name = Value(name),
       expiryDate = Value(expiryDate);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? docType,
    Expression<String>? name,
    Expression<String>? number,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? expiryDate,
    Expression<String>? filePath,
    Expression<int>? reminderDays,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (docType != null) 'doc_type': docType,
      if (name != null) 'name': name,
      if (number != null) 'number': number,
      if (issueDate != null) 'issue_date': issueDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (filePath != null) 'file_path': filePath,
      if (reminderDays != null) 'reminder_days': reminderDays,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? docType,
    Value<String>? name,
    Value<String?>? number,
    Value<DateTime?>? issueDate,
    Value<DateTime>? expiryDate,
    Value<String?>? filePath,
    Value<int>? reminderDays,
    Value<DateTime>? createdAt,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      docType: docType ?? this.docType,
      name: name ?? this.name,
      number: number ?? this.number,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      filePath: filePath ?? this.filePath,
      reminderDays: reminderDays ?? this.reminderDays,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (docType.present) {
      map['doc_type'] = Variable<String>(docType.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (reminderDays.present) {
      map['reminder_days'] = Variable<int>(reminderDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('docType: $docType, ')
          ..write('name: $name, ')
          ..write('number: $number, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('filePath: $filePath, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InsuranceTable extends Insurance
    with TableInfo<$InsuranceTable, InsuranceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsuranceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _policyNumberMeta = const VerificationMeta(
    'policyNumber',
  );
  @override
  late final GeneratedColumn<String> policyNumber = GeneratedColumn<String>(
    'policy_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverageMeta = const VerificationMeta(
    'coverage',
  );
  @override
  late final GeneratedColumn<String> coverage = GeneratedColumn<String>(
    'coverage',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _premiumMeta = const VerificationMeta(
    'premium',
  );
  @override
  late final GeneratedColumn<int> premium = GeneratedColumn<int>(
    'premium',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderDaysMeta = const VerificationMeta(
    'reminderDays',
  );
  @override
  late final GeneratedColumn<int> reminderDays = GeneratedColumn<int>(
    'reminder_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    provider,
    policyNumber,
    coverage,
    startDate,
    endDate,
    premium,
    reminderDays,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insurance';
  @override
  VerificationContext validateIntegrity(
    Insertable<InsuranceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('policy_number')) {
      context.handle(
        _policyNumberMeta,
        policyNumber.isAcceptableOrUnknown(
          data['policy_number']!,
          _policyNumberMeta,
        ),
      );
    }
    if (data.containsKey('coverage')) {
      context.handle(
        _coverageMeta,
        coverage.isAcceptableOrUnknown(data['coverage']!, _coverageMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('premium')) {
      context.handle(
        _premiumMeta,
        premium.isAcceptableOrUnknown(data['premium']!, _premiumMeta),
      );
    }
    if (data.containsKey('reminder_days')) {
      context.handle(
        _reminderDaysMeta,
        reminderDays.isAcceptableOrUnknown(
          data['reminder_days']!,
          _reminderDaysMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InsuranceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InsuranceData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      policyNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}policy_number'],
      ),
      coverage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coverage'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      premium: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}premium'],
      ),
      reminderDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_days'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InsuranceTable createAlias(String alias) {
    return $InsuranceTable(attachedDatabase, alias);
  }
}

class InsuranceData extends DataClass implements Insertable<InsuranceData> {
  final int id;
  final int vehicleId;
  final String provider;
  final String? policyNumber;
  final String? coverage;
  final DateTime? startDate;
  final DateTime endDate;

  /// Decisión: monto como entero (unidad mínima de la moneda).
  final int? premium;
  final int reminderDays;
  final DateTime createdAt;
  const InsuranceData({
    required this.id,
    required this.vehicleId,
    required this.provider,
    this.policyNumber,
    this.coverage,
    this.startDate,
    required this.endDate,
    this.premium,
    required this.reminderDays,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['provider'] = Variable<String>(provider);
    if (!nullToAbsent || policyNumber != null) {
      map['policy_number'] = Variable<String>(policyNumber);
    }
    if (!nullToAbsent || coverage != null) {
      map['coverage'] = Variable<String>(coverage);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    map['end_date'] = Variable<DateTime>(endDate);
    if (!nullToAbsent || premium != null) {
      map['premium'] = Variable<int>(premium);
    }
    map['reminder_days'] = Variable<int>(reminderDays);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InsuranceCompanion toCompanion(bool nullToAbsent) {
    return InsuranceCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      provider: Value(provider),
      policyNumber: policyNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(policyNumber),
      coverage: coverage == null && nullToAbsent
          ? const Value.absent()
          : Value(coverage),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: Value(endDate),
      premium: premium == null && nullToAbsent
          ? const Value.absent()
          : Value(premium),
      reminderDays: Value(reminderDays),
      createdAt: Value(createdAt),
    );
  }

  factory InsuranceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InsuranceData(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      provider: serializer.fromJson<String>(json['provider']),
      policyNumber: serializer.fromJson<String?>(json['policyNumber']),
      coverage: serializer.fromJson<String?>(json['coverage']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      premium: serializer.fromJson<int?>(json['premium']),
      reminderDays: serializer.fromJson<int>(json['reminderDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'provider': serializer.toJson<String>(provider),
      'policyNumber': serializer.toJson<String?>(policyNumber),
      'coverage': serializer.toJson<String?>(coverage),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'premium': serializer.toJson<int?>(premium),
      'reminderDays': serializer.toJson<int>(reminderDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InsuranceData copyWith({
    int? id,
    int? vehicleId,
    String? provider,
    Value<String?> policyNumber = const Value.absent(),
    Value<String?> coverage = const Value.absent(),
    Value<DateTime?> startDate = const Value.absent(),
    DateTime? endDate,
    Value<int?> premium = const Value.absent(),
    int? reminderDays,
    DateTime? createdAt,
  }) => InsuranceData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    provider: provider ?? this.provider,
    policyNumber: policyNumber.present ? policyNumber.value : this.policyNumber,
    coverage: coverage.present ? coverage.value : this.coverage,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate ?? this.endDate,
    premium: premium.present ? premium.value : this.premium,
    reminderDays: reminderDays ?? this.reminderDays,
    createdAt: createdAt ?? this.createdAt,
  );
  InsuranceData copyWithCompanion(InsuranceCompanion data) {
    return InsuranceData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      provider: data.provider.present ? data.provider.value : this.provider,
      policyNumber: data.policyNumber.present
          ? data.policyNumber.value
          : this.policyNumber,
      coverage: data.coverage.present ? data.coverage.value : this.coverage,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      premium: data.premium.present ? data.premium.value : this.premium,
      reminderDays: data.reminderDays.present
          ? data.reminderDays.value
          : this.reminderDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InsuranceData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('provider: $provider, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('coverage: $coverage, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('premium: $premium, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    provider,
    policyNumber,
    coverage,
    startDate,
    endDate,
    premium,
    reminderDays,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InsuranceData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.provider == this.provider &&
          other.policyNumber == this.policyNumber &&
          other.coverage == this.coverage &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.premium == this.premium &&
          other.reminderDays == this.reminderDays &&
          other.createdAt == this.createdAt);
}

class InsuranceCompanion extends UpdateCompanion<InsuranceData> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> provider;
  final Value<String?> policyNumber;
  final Value<String?> coverage;
  final Value<DateTime?> startDate;
  final Value<DateTime> endDate;
  final Value<int?> premium;
  final Value<int> reminderDays;
  final Value<DateTime> createdAt;
  const InsuranceCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.provider = const Value.absent(),
    this.policyNumber = const Value.absent(),
    this.coverage = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.premium = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InsuranceCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String provider,
    this.policyNumber = const Value.absent(),
    this.coverage = const Value.absent(),
    this.startDate = const Value.absent(),
    required DateTime endDate,
    this.premium = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       provider = Value(provider),
       endDate = Value(endDate);
  static Insertable<InsuranceData> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? provider,
    Expression<String>? policyNumber,
    Expression<String>? coverage,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? premium,
    Expression<int>? reminderDays,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (provider != null) 'provider': provider,
      if (policyNumber != null) 'policy_number': policyNumber,
      if (coverage != null) 'coverage': coverage,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (premium != null) 'premium': premium,
      if (reminderDays != null) 'reminder_days': reminderDays,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InsuranceCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? provider,
    Value<String?>? policyNumber,
    Value<String?>? coverage,
    Value<DateTime?>? startDate,
    Value<DateTime>? endDate,
    Value<int?>? premium,
    Value<int>? reminderDays,
    Value<DateTime>? createdAt,
  }) {
    return InsuranceCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      provider: provider ?? this.provider,
      policyNumber: policyNumber ?? this.policyNumber,
      coverage: coverage ?? this.coverage,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      premium: premium ?? this.premium,
      reminderDays: reminderDays ?? this.reminderDays,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (policyNumber.present) {
      map['policy_number'] = Variable<String>(policyNumber.value);
    }
    if (coverage.present) {
      map['coverage'] = Variable<String>(coverage.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (premium.present) {
      map['premium'] = Variable<int>(premium.value);
    }
    if (reminderDays.present) {
      map['reminder_days'] = Variable<int>(reminderDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsuranceCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('provider: $provider, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('coverage: $coverage, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('premium: $premium, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TaxesTable extends Taxes with TableInfo<$TaxesTable, Taxe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _taxTypeMeta = const VerificationMeta(
    'taxType',
  );
  @override
  late final GeneratedColumn<String> taxType = GeneratedColumn<String>(
    'tax_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidDateMeta = const VerificationMeta(
    'paidDate',
  );
  @override
  late final GeneratedColumn<DateTime> paidDate = GeneratedColumn<DateTime>(
    'paid_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderDaysMeta = const VerificationMeta(
    'reminderDays',
  );
  @override
  late final GeneratedColumn<int> reminderDays = GeneratedColumn<int>(
    'reminder_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    taxType,
    amount,
    dueDate,
    paidDate,
    reminderDays,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'taxes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Taxe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('tax_type')) {
      context.handle(
        _taxTypeMeta,
        taxType.isAcceptableOrUnknown(data['tax_type']!, _taxTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_taxTypeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('paid_date')) {
      context.handle(
        _paidDateMeta,
        paidDate.isAcceptableOrUnknown(data['paid_date']!, _paidDateMeta),
      );
    }
    if (data.containsKey('reminder_days')) {
      context.handle(
        _reminderDaysMeta,
        reminderDays.isAcceptableOrUnknown(
          data['reminder_days']!,
          _reminderDaysMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Taxe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Taxe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      taxType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      paidDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_date'],
      ),
      reminderDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_days'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TaxesTable createAlias(String alias) {
    return $TaxesTable(attachedDatabase, alias);
  }
}

class Taxe extends DataClass implements Insertable<Taxe> {
  final int id;
  final int vehicleId;
  final String taxType;

  /// Decisión: monto como entero (unidad mínima de la moneda).
  final int amount;
  final DateTime dueDate;

  /// Nullable: null = impuesto aún no pagado.
  final DateTime? paidDate;
  final int reminderDays;
  final DateTime createdAt;
  const Taxe({
    required this.id,
    required this.vehicleId,
    required this.taxType,
    required this.amount,
    required this.dueDate,
    this.paidDate,
    required this.reminderDays,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['tax_type'] = Variable<String>(taxType);
    map['amount'] = Variable<int>(amount);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || paidDate != null) {
      map['paid_date'] = Variable<DateTime>(paidDate);
    }
    map['reminder_days'] = Variable<int>(reminderDays);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TaxesCompanion toCompanion(bool nullToAbsent) {
    return TaxesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      taxType: Value(taxType),
      amount: Value(amount),
      dueDate: Value(dueDate),
      paidDate: paidDate == null && nullToAbsent
          ? const Value.absent()
          : Value(paidDate),
      reminderDays: Value(reminderDays),
      createdAt: Value(createdAt),
    );
  }

  factory Taxe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Taxe(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      taxType: serializer.fromJson<String>(json['taxType']),
      amount: serializer.fromJson<int>(json['amount']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      paidDate: serializer.fromJson<DateTime?>(json['paidDate']),
      reminderDays: serializer.fromJson<int>(json['reminderDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'taxType': serializer.toJson<String>(taxType),
      'amount': serializer.toJson<int>(amount),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'paidDate': serializer.toJson<DateTime?>(paidDate),
      'reminderDays': serializer.toJson<int>(reminderDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Taxe copyWith({
    int? id,
    int? vehicleId,
    String? taxType,
    int? amount,
    DateTime? dueDate,
    Value<DateTime?> paidDate = const Value.absent(),
    int? reminderDays,
    DateTime? createdAt,
  }) => Taxe(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    taxType: taxType ?? this.taxType,
    amount: amount ?? this.amount,
    dueDate: dueDate ?? this.dueDate,
    paidDate: paidDate.present ? paidDate.value : this.paidDate,
    reminderDays: reminderDays ?? this.reminderDays,
    createdAt: createdAt ?? this.createdAt,
  );
  Taxe copyWithCompanion(TaxesCompanion data) {
    return Taxe(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      taxType: data.taxType.present ? data.taxType.value : this.taxType,
      amount: data.amount.present ? data.amount.value : this.amount,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      paidDate: data.paidDate.present ? data.paidDate.value : this.paidDate,
      reminderDays: data.reminderDays.present
          ? data.reminderDays.value
          : this.reminderDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Taxe(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('taxType: $taxType, ')
          ..write('amount: $amount, ')
          ..write('dueDate: $dueDate, ')
          ..write('paidDate: $paidDate, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    taxType,
    amount,
    dueDate,
    paidDate,
    reminderDays,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Taxe &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.taxType == this.taxType &&
          other.amount == this.amount &&
          other.dueDate == this.dueDate &&
          other.paidDate == this.paidDate &&
          other.reminderDays == this.reminderDays &&
          other.createdAt == this.createdAt);
}

class TaxesCompanion extends UpdateCompanion<Taxe> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> taxType;
  final Value<int> amount;
  final Value<DateTime> dueDate;
  final Value<DateTime?> paidDate;
  final Value<int> reminderDays;
  final Value<DateTime> createdAt;
  const TaxesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.taxType = const Value.absent(),
    this.amount = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TaxesCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String taxType,
    required int amount,
    required DateTime dueDate,
    this.paidDate = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       taxType = Value(taxType),
       amount = Value(amount),
       dueDate = Value(dueDate);
  static Insertable<Taxe> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? taxType,
    Expression<int>? amount,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? paidDate,
    Expression<int>? reminderDays,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (taxType != null) 'tax_type': taxType,
      if (amount != null) 'amount': amount,
      if (dueDate != null) 'due_date': dueDate,
      if (paidDate != null) 'paid_date': paidDate,
      if (reminderDays != null) 'reminder_days': reminderDays,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TaxesCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? taxType,
    Value<int>? amount,
    Value<DateTime>? dueDate,
    Value<DateTime?>? paidDate,
    Value<int>? reminderDays,
    Value<DateTime>? createdAt,
  }) {
    return TaxesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      taxType: taxType ?? this.taxType,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
      reminderDays: reminderDays ?? this.reminderDays,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (taxType.present) {
      map['tax_type'] = Variable<String>(taxType.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (paidDate.present) {
      map['paid_date'] = Variable<DateTime>(paidDate.value);
    }
    if (reminderDays.present) {
      map['reminder_days'] = Variable<int>(reminderDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('taxType: $taxType, ')
          ..write('amount: $amount, ')
          ..write('dueDate: $dueDate, ')
          ..write('paidDate: $paidDate, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedEntityMeta = const VerificationMeta(
    'relatedEntity',
  );
  @override
  late final GeneratedColumn<String> relatedEntity = GeneratedColumn<String>(
    'related_entity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedIdMeta = const VerificationMeta(
    'relatedId',
  );
  @override
  late final GeneratedColumn<int> relatedId = GeneratedColumn<int>(
    'related_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSentMeta = const VerificationMeta('isSent');
  @override
  late final GeneratedColumn<bool> isSent = GeneratedColumn<bool>(
    'is_sent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    type,
    title,
    body,
    relatedEntity,
    relatedId,
    scheduledAt,
    isSent,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('related_entity')) {
      context.handle(
        _relatedEntityMeta,
        relatedEntity.isAcceptableOrUnknown(
          data['related_entity']!,
          _relatedEntityMeta,
        ),
      );
    }
    if (data.containsKey('related_id')) {
      context.handle(
        _relatedIdMeta,
        relatedId.isAcceptableOrUnknown(data['related_id']!, _relatedIdMeta),
      );
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    }
    if (data.containsKey('is_sent')) {
      context.handle(
        _isSentMeta,
        isSent.isAcceptableOrUnknown(data['is_sent']!, _isSentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      ),
      relatedEntity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_entity'],
      ),
      relatedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_id'],
      ),
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      ),
      isSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sent'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final int id;

  /// Nullable: alertas globales que no dependen de un vehículo.
  final int? vehicleId;
  final String type;
  final String title;
  final String? body;
  final String? relatedEntity;
  final int? relatedId;
  final DateTime? scheduledAt;
  final bool isSent;
  final DateTime createdAt;
  const Notification({
    required this.id,
    this.vehicleId,
    required this.type,
    required this.title,
    this.body,
    this.relatedEntity,
    this.relatedId,
    this.scheduledAt,
    required this.isSent,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || vehicleId != null) {
      map['vehicle_id'] = Variable<int>(vehicleId);
    }
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || relatedEntity != null) {
      map['related_entity'] = Variable<String>(relatedEntity);
    }
    if (!nullToAbsent || relatedId != null) {
      map['related_id'] = Variable<int>(relatedId);
    }
    if (!nullToAbsent || scheduledAt != null) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    }
    map['is_sent'] = Variable<bool>(isSent);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      vehicleId: vehicleId == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleId),
      type: Value(type),
      title: Value(title),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      relatedEntity: relatedEntity == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedEntity),
      relatedId: relatedId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedId),
      scheduledAt: scheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledAt),
      isSent: Value(isSent),
      createdAt: Value(createdAt),
    );
  }

  factory Notification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int?>(json['vehicleId']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String?>(json['body']),
      relatedEntity: serializer.fromJson<String?>(json['relatedEntity']),
      relatedId: serializer.fromJson<int?>(json['relatedId']),
      scheduledAt: serializer.fromJson<DateTime?>(json['scheduledAt']),
      isSent: serializer.fromJson<bool>(json['isSent']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int?>(vehicleId),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String?>(body),
      'relatedEntity': serializer.toJson<String?>(relatedEntity),
      'relatedId': serializer.toJson<int?>(relatedId),
      'scheduledAt': serializer.toJson<DateTime?>(scheduledAt),
      'isSent': serializer.toJson<bool>(isSent),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Notification copyWith({
    int? id,
    Value<int?> vehicleId = const Value.absent(),
    String? type,
    String? title,
    Value<String?> body = const Value.absent(),
    Value<String?> relatedEntity = const Value.absent(),
    Value<int?> relatedId = const Value.absent(),
    Value<DateTime?> scheduledAt = const Value.absent(),
    bool? isSent,
    DateTime? createdAt,
  }) => Notification(
    id: id ?? this.id,
    vehicleId: vehicleId.present ? vehicleId.value : this.vehicleId,
    type: type ?? this.type,
    title: title ?? this.title,
    body: body.present ? body.value : this.body,
    relatedEntity: relatedEntity.present
        ? relatedEntity.value
        : this.relatedEntity,
    relatedId: relatedId.present ? relatedId.value : this.relatedId,
    scheduledAt: scheduledAt.present ? scheduledAt.value : this.scheduledAt,
    isSent: isSent ?? this.isSent,
    createdAt: createdAt ?? this.createdAt,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      relatedEntity: data.relatedEntity.present
          ? data.relatedEntity.value
          : this.relatedEntity,
      relatedId: data.relatedId.present ? data.relatedId.value : this.relatedId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      isSent: data.isSent.present ? data.isSent.value : this.isSent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('relatedEntity: $relatedEntity, ')
          ..write('relatedId: $relatedId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('isSent: $isSent, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    type,
    title,
    body,
    relatedEntity,
    relatedId,
    scheduledAt,
    isSent,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.type == this.type &&
          other.title == this.title &&
          other.body == this.body &&
          other.relatedEntity == this.relatedEntity &&
          other.relatedId == this.relatedId &&
          other.scheduledAt == this.scheduledAt &&
          other.isSent == this.isSent &&
          other.createdAt == this.createdAt);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<int?> vehicleId;
  final Value<String> type;
  final Value<String> title;
  final Value<String?> body;
  final Value<String?> relatedEntity;
  final Value<int?> relatedId;
  final Value<DateTime?> scheduledAt;
  final Value<bool> isSent;
  final Value<DateTime> createdAt;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.relatedEntity = const Value.absent(),
    this.relatedId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.isSent = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    required String type,
    required String title,
    this.body = const Value.absent(),
    this.relatedEntity = const Value.absent(),
    this.relatedId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.isSent = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : type = Value(type),
       title = Value(title);
  static Insertable<Notification> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? relatedEntity,
    Expression<int>? relatedId,
    Expression<DateTime>? scheduledAt,
    Expression<bool>? isSent,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (relatedEntity != null) 'related_entity': relatedEntity,
      if (relatedId != null) 'related_id': relatedId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (isSent != null) 'is_sent': isSent,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  NotificationsCompanion copyWith({
    Value<int>? id,
    Value<int?>? vehicleId,
    Value<String>? type,
    Value<String>? title,
    Value<String?>? body,
    Value<String?>? relatedEntity,
    Value<int?>? relatedId,
    Value<DateTime?>? scheduledAt,
    Value<bool>? isSent,
    Value<DateTime>? createdAt,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      relatedEntity: relatedEntity ?? this.relatedEntity,
      relatedId: relatedId ?? this.relatedId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      isSent: isSent ?? this.isSent,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (relatedEntity.present) {
      map['related_entity'] = Variable<String>(relatedEntity.value);
    }
    if (relatedId.present) {
      map['related_id'] = Variable<int>(relatedId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (isSent.present) {
      map['is_sent'] = Variable<bool>(isSent.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('relatedEntity: $relatedEntity, ')
          ..write('relatedId: $relatedId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('isSent: $isSent, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    path,
    mimeType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class Attachment extends DataClass implements Insertable<Attachment> {
  final int id;

  /// vehicle | document | maintenance | expense (validado por la UI).
  final String entityType;
  final int entityId;

  /// Ruta relativa dentro de `app_documents/...`. Nunca rutas absolutas.
  final String path;
  final String? mimeType;
  final DateTime createdAt;
  const Attachment({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.path,
    this.mimeType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<int>(entityId);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      path: Value(path),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      createdAt: Value(createdAt),
    );
  }

  factory Attachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int>(json['entityId']),
      path: serializer.fromJson<String>(json['path']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int>(entityId),
      'path': serializer.toJson<String>(path),
      'mimeType': serializer.toJson<String?>(mimeType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Attachment copyWith({
    int? id,
    String? entityType,
    int? entityId,
    String? path,
    Value<String?> mimeType = const Value.absent(),
    DateTime? createdAt,
  }) => Attachment(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    path: path ?? this.path,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    createdAt: createdAt ?? this.createdAt,
  );
  Attachment copyWithCompanion(AttachmentsCompanion data) {
    return Attachment(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      path: data.path.present ? data.path.value : this.path,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('path: $path, ')
          ..write('mimeType: $mimeType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entityType, entityId, path, mimeType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.path == this.path &&
          other.mimeType == this.mimeType &&
          other.createdAt == this.createdAt);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<int> entityId;
  final Value<String> path;
  final Value<String?> mimeType;
  final Value<DateTime> createdAt;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.path = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required int entityId,
    required String path,
    this.mimeType = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : entityType = Value(entityType),
       entityId = Value(entityId),
       path = Value(path);
  static Insertable<Attachment> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? path,
    Expression<String>? mimeType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (path != null) 'path': path,
      if (mimeType != null) 'mime_type': mimeType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AttachmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<int>? entityId,
    Value<String>? path,
    Value<String?>? mimeType,
    Value<DateTime>? createdAt,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      path: path ?? this.path,
      mimeType: mimeType ?? this.mimeType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('path: $path, ')
          ..write('mimeType: $mimeType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ActivityLogsTable extends ActivityLogs
    with TableInfo<$ActivityLogsTable, ActivityLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    entityType,
    entityId,
    detail,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      ),
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ActivityLogsTable createAlias(String alias) {
    return $ActivityLogsTable(attachedDatabase, alias);
  }
}

class ActivityLog extends DataClass implements Insertable<ActivityLog> {
  final int id;

  /// created | updated | deleted.
  final String action;
  final String entityType;
  final int? entityId;
  final String? detail;
  final DateTime createdAt;
  const ActivityLog({
    required this.id,
    required this.action,
    required this.entityType,
    this.entityId,
    this.detail,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<int>(entityId);
    }
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ActivityLogsCompanion toCompanion(bool nullToAbsent) {
    return ActivityLogsCompanion(
      id: Value(id),
      action: Value(action),
      entityType: Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
      createdAt: Value(createdAt),
    );
  }

  factory ActivityLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityLog(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int?>(json['entityId']),
      detail: serializer.fromJson<String?>(json['detail']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int?>(entityId),
      'detail': serializer.toJson<String?>(detail),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ActivityLog copyWith({
    int? id,
    String? action,
    String? entityType,
    Value<int?> entityId = const Value.absent(),
    Value<String?> detail = const Value.absent(),
    DateTime? createdAt,
  }) => ActivityLog(
    id: id ?? this.id,
    action: action ?? this.action,
    entityType: entityType ?? this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    detail: detail.present ? detail.value : this.detail,
    createdAt: createdAt ?? this.createdAt,
  );
  ActivityLog copyWithCompanion(ActivityLogsCompanion data) {
    return ActivityLog(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      detail: data.detail.present ? data.detail.value : this.detail,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLog(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('detail: $detail, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, action, entityType, entityId, detail, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityLog &&
          other.id == this.id &&
          other.action == this.action &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.detail == this.detail &&
          other.createdAt == this.createdAt);
}

class ActivityLogsCompanion extends UpdateCompanion<ActivityLog> {
  final Value<int> id;
  final Value<String> action;
  final Value<String> entityType;
  final Value<int?> entityId;
  final Value<String?> detail;
  final Value<DateTime> createdAt;
  const ActivityLogsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.detail = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ActivityLogsCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    required String entityType,
    this.entityId = const Value.absent(),
    this.detail = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : action = Value(action),
       entityType = Value(entityType);
  static Insertable<ActivityLog> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? detail,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (detail != null) 'detail': detail,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ActivityLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? action,
    Value<String>? entityType,
    Value<int?>? entityId,
    Value<String?>? detail,
    Value<DateTime>? createdAt,
  }) {
    return ActivityLogsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      detail: detail ?? this.detail,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLogsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('detail: $detail, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $FuelRecordsTable fuelRecords = $FuelRecordsTable(this);
  late final $MaintenanceTypesTable maintenanceTypes = $MaintenanceTypesTable(
    this,
  );
  late final $MaintenanceTable maintenance = $MaintenanceTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $InsuranceTable insurance = $InsuranceTable(this);
  late final $TaxesTable taxes = $TaxesTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $ActivityLogsTable activityLogs = $ActivityLogsTable(this);
  late final Index vehiclesUserPlateUnique = Index(
    'vehicles_user_plate_unique',
    'CREATE UNIQUE INDEX vehicles_user_plate_unique ON vehicles (user_id, plate)',
  );
  late final Index fuelRecordsVehicleDateIdx = Index(
    'fuel_records_vehicle_date_idx',
    'CREATE INDEX fuel_records_vehicle_date_idx ON fuel_records (vehicle_id, date)',
  );
  late final Index maintenanceVehicleDateIdx = Index(
    'maintenance_vehicle_date_idx',
    'CREATE INDEX maintenance_vehicle_date_idx ON maintenance (vehicle_id, date)',
  );
  late final Index expensesVehicleDateIdx = Index(
    'expenses_vehicle_date_idx',
    'CREATE INDEX expenses_vehicle_date_idx ON expenses (vehicle_id, date)',
  );
  late final Index documentsVehicleIdx = Index(
    'documents_vehicle_idx',
    'CREATE INDEX documents_vehicle_idx ON documents (vehicle_id)',
  );
  late final Index documentsExpiryIdx = Index(
    'documents_expiry_idx',
    'CREATE INDEX documents_expiry_idx ON documents (expiry_date)',
  );
  late final Index insuranceVehicleIdx = Index(
    'insurance_vehicle_idx',
    'CREATE INDEX insurance_vehicle_idx ON insurance (vehicle_id)',
  );
  late final Index insuranceEndDateIdx = Index(
    'insurance_end_date_idx',
    'CREATE INDEX insurance_end_date_idx ON insurance (end_date)',
  );
  late final Index taxesVehicleIdx = Index(
    'taxes_vehicle_idx',
    'CREATE INDEX taxes_vehicle_idx ON taxes (vehicle_id)',
  );
  late final Index taxesDueDateIdx = Index(
    'taxes_due_date_idx',
    'CREATE INDEX taxes_due_date_idx ON taxes (due_date)',
  );
  late final Index notificationsVehicleIdx = Index(
    'notifications_vehicle_idx',
    'CREATE INDEX notifications_vehicle_idx ON notifications (vehicle_id)',
  );
  late final Index attachmentsEntityIdx = Index(
    'attachments_entity_idx',
    'CREATE INDEX attachments_entity_idx ON attachments (entity_type, entity_id)',
  );
  late final Index activityLogsEntityIdx = Index(
    'activity_logs_entity_idx',
    'CREATE INDEX activity_logs_entity_idx ON activity_logs (entity_type, entity_id)',
  );
  late final Index activityLogsCreatedIdx = Index(
    'activity_logs_created_idx',
    'CREATE INDEX activity_logs_created_idx ON activity_logs (created_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    vehicles,
    fuelRecords,
    maintenanceTypes,
    maintenance,
    expenses,
    documents,
    insurance,
    taxes,
    notifications,
    attachments,
    activityLogs,
    vehiclesUserPlateUnique,
    fuelRecordsVehicleDateIdx,
    maintenanceVehicleDateIdx,
    expensesVehicleDateIdx,
    documentsVehicleIdx,
    documentsExpiryIdx,
    insuranceVehicleIdx,
    insuranceEndDateIdx,
    taxesVehicleIdx,
    taxesDueDateIdx,
    notificationsVehicleIdx,
    attachmentsEntityIdx,
    activityLogsEntityIdx,
    activityLogsCreatedIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vehicles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fuel_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('documents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('insurance', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('taxes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notifications', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<String> currency,
      Value<DateTime> createdAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<String> currency,
      Value<DateTime> createdAt,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VehiclesTable, List<Vehicle>> _vehiclesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.vehicles,
    aliasName: $_aliasNameGenerator(db.users.id, db.vehicles.userId),
  );

  $$VehiclesTableProcessedTableManager get vehiclesRefs {
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehiclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vehiclesRefs(
    Expression<bool> Function($$VehiclesTableFilterComposer f) f,
  ) {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> vehiclesRefs<T extends Object>(
    Expression<T> Function($$VehiclesTableAnnotationComposer a) f,
  ) {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool vehiclesRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                phone: phone,
                currency: currency,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                phone: phone,
                currency: currency,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({vehiclesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (vehiclesRefs) db.vehicles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vehiclesRefs)
                    await $_getPrefetchedData<User, $UsersTable, Vehicle>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._vehiclesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).vehiclesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool vehiclesRefs})
    >;
typedef $$VehiclesTableCreateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      required int userId,
      required String brand,
      required String model,
      Value<int?> year,
      Value<String?> plate,
      required double odometerKm,
      required String fuelType,
      Value<String> status,
      Value<String?> photoPath,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$VehiclesTableUpdateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> brand,
      Value<String> model,
      Value<int?> year,
      Value<String?> plate,
      Value<double> odometerKm,
      Value<String> fuelType,
      Value<String> status,
      Value<String?> photoPath,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.vehicles.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FuelRecordsTable, List<FuelRecord>>
  _fuelRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelRecords,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.fuelRecords.vehicleId),
  );

  $$FuelRecordsTableProcessedTableManager get fuelRecordsRefs {
    final manager = $$FuelRecordsTableTableManager(
      $_db,
      $_db.fuelRecords,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MaintenanceTable, List<MaintenanceData>>
  _maintenanceRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenance,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.maintenance.vehicleId),
  );

  $$MaintenanceTableProcessedTableManager get maintenanceRefs {
    final manager = $$MaintenanceTableTableManager(
      $_db,
      $_db.maintenance,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_maintenanceRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.expenses.vehicleId),
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.documents.vehicleId),
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InsuranceTable, List<InsuranceData>>
  _insuranceRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.insurance,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.insurance.vehicleId),
  );

  $$InsuranceTableProcessedTableManager get insuranceRefs {
    final manager = $$InsuranceTableTableManager(
      $_db,
      $_db.insurance,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_insuranceRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TaxesTable, List<Taxe>> _taxesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.taxes,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.taxes.vehicleId),
  );

  $$TaxesTableProcessedTableManager get taxesRefs {
    final manager = $$TaxesTableTableManager(
      $_db,
      $_db.taxes,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_taxesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotificationsTable, List<Notification>>
  _notificationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.notifications,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.notifications.vehicleId),
  );

  $$NotificationsTableProcessedTableManager get notificationsRefs {
    final manager = $$NotificationsTableTableManager(
      $_db,
      $_db.notifications,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_notificationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plate => $composableBuilder(
    column: $table.plate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> fuelRecordsRefs(
    Expression<bool> Function($$FuelRecordsTableFilterComposer f) f,
  ) {
    final $$FuelRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelRecordsTableFilterComposer(
            $db: $db,
            $table: $db.fuelRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceRefs(
    Expression<bool> Function($$MaintenanceTableFilterComposer f) f,
  ) {
    final $$MaintenanceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenance,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTableFilterComposer(
            $db: $db,
            $table: $db.maintenance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> insuranceRefs(
    Expression<bool> Function($$InsuranceTableFilterComposer f) f,
  ) {
    final $$InsuranceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.insurance,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsuranceTableFilterComposer(
            $db: $db,
            $table: $db.insurance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> taxesRefs(
    Expression<bool> Function($$TaxesTableFilterComposer f) f,
  ) {
    final $$TaxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taxes,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaxesTableFilterComposer(
            $db: $db,
            $table: $db.taxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notificationsRefs(
    Expression<bool> Function($$NotificationsTableFilterComposer f) f,
  ) {
    final $$NotificationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notifications,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationsTableFilterComposer(
            $db: $db,
            $table: $db.notifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plate => $composableBuilder(
    column: $table.plate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get plate =>
      $composableBuilder(column: $table.plate, builder: (column) => column);

  GeneratedColumn<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> fuelRecordsRefs<T extends Object>(
    Expression<T> Function($$FuelRecordsTableAnnotationComposer a) f,
  ) {
    final $$FuelRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenanceRefs<T extends Object>(
    Expression<T> Function($$MaintenanceTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenance,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> insuranceRefs<T extends Object>(
    Expression<T> Function($$InsuranceTableAnnotationComposer a) f,
  ) {
    final $$InsuranceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.insurance,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsuranceTableAnnotationComposer(
            $db: $db,
            $table: $db.insurance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> taxesRefs<T extends Object>(
    Expression<T> Function($$TaxesTableAnnotationComposer a) f,
  ) {
    final $$TaxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taxes,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaxesTableAnnotationComposer(
            $db: $db,
            $table: $db.taxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notificationsRefs<T extends Object>(
    Expression<T> Function($$NotificationsTableAnnotationComposer a) f,
  ) {
    final $$NotificationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notifications,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationsTableAnnotationComposer(
            $db: $db,
            $table: $db.notifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, $$VehiclesTableReferences),
          Vehicle,
          PrefetchHooks Function({
            bool userId,
            bool fuelRecordsRefs,
            bool maintenanceRefs,
            bool expensesRefs,
            bool documentsRefs,
            bool insuranceRefs,
            bool taxesRefs,
            bool notificationsRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<String?> plate = const Value.absent(),
                Value<double> odometerKm = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                userId: userId,
                brand: brand,
                model: model,
                year: year,
                plate: plate,
                odometerKm: odometerKm,
                fuelType: fuelType,
                status: status,
                photoPath: photoPath,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String brand,
                required String model,
                Value<int?> year = const Value.absent(),
                Value<String?> plate = const Value.absent(),
                required double odometerKm,
                required String fuelType,
                Value<String> status = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                userId: userId,
                brand: brand,
                model: model,
                year: year,
                plate: plate,
                odometerKm: odometerKm,
                fuelType: fuelType,
                status: status,
                photoPath: photoPath,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                fuelRecordsRefs = false,
                maintenanceRefs = false,
                expensesRefs = false,
                documentsRefs = false,
                insuranceRefs = false,
                taxesRefs = false,
                notificationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fuelRecordsRefs) db.fuelRecords,
                    if (maintenanceRefs) db.maintenance,
                    if (expensesRefs) db.expenses,
                    if (documentsRefs) db.documents,
                    if (insuranceRefs) db.insurance,
                    if (taxesRefs) db.taxes,
                    if (notificationsRefs) db.notifications,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$VehiclesTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$VehiclesTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fuelRecordsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          FuelRecord
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          MaintenanceData
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._maintenanceRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Expense
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Document
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (insuranceRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          InsuranceData
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._insuranceRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).insuranceRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (taxesRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Taxe
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._taxesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).taxesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (notificationsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Notification
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._notificationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).notificationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, $$VehiclesTableReferences),
      Vehicle,
      PrefetchHooks Function({
        bool userId,
        bool fuelRecordsRefs,
        bool maintenanceRefs,
        bool expensesRefs,
        bool documentsRefs,
        bool insuranceRefs,
        bool taxesRefs,
        bool notificationsRefs,
      })
    >;
typedef $$FuelRecordsTableCreateCompanionBuilder =
    FuelRecordsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required DateTime date,
      required double odometerKm,
      required double liters,
      required int unitPrice,
      required int totalCost,
      required bool isFullTank,
      Value<String?> station,
      Value<String?> notes,
    });
typedef $$FuelRecordsTableUpdateCompanionBuilder =
    FuelRecordsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<DateTime> date,
      Value<double> odometerKm,
      Value<double> liters,
      Value<int> unitPrice,
      Value<int> totalCost,
      Value<bool> isFullTank,
      Value<String?> station,
      Value<String?> notes,
    });

final class $$FuelRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $FuelRecordsTable, FuelRecord> {
  $$FuelRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.fuelRecords.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $FuelRecordsTable> {
  $$FuelRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelRecordsTable> {
  $$FuelRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelRecordsTable> {
  $$FuelRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get liters =>
      $composableBuilder(column: $table.liters, builder: (column) => column);

  GeneratedColumn<int> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get station =>
      $composableBuilder(column: $table.station, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelRecordsTable,
          FuelRecord,
          $$FuelRecordsTableFilterComposer,
          $$FuelRecordsTableOrderingComposer,
          $$FuelRecordsTableAnnotationComposer,
          $$FuelRecordsTableCreateCompanionBuilder,
          $$FuelRecordsTableUpdateCompanionBuilder,
          (FuelRecord, $$FuelRecordsTableReferences),
          FuelRecord,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$FuelRecordsTableTableManager(_$AppDatabase db, $FuelRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> odometerKm = const Value.absent(),
                Value<double> liters = const Value.absent(),
                Value<int> unitPrice = const Value.absent(),
                Value<int> totalCost = const Value.absent(),
                Value<bool> isFullTank = const Value.absent(),
                Value<String?> station = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FuelRecordsCompanion(
                id: id,
                vehicleId: vehicleId,
                date: date,
                odometerKm: odometerKm,
                liters: liters,
                unitPrice: unitPrice,
                totalCost: totalCost,
                isFullTank: isFullTank,
                station: station,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required DateTime date,
                required double odometerKm,
                required double liters,
                required int unitPrice,
                required int totalCost,
                required bool isFullTank,
                Value<String?> station = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FuelRecordsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                date: date,
                odometerKm: odometerKm,
                liters: liters,
                unitPrice: unitPrice,
                totalCost: totalCost,
                isFullTank: isFullTank,
                station: station,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FuelRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$FuelRecordsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$FuelRecordsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelRecordsTable,
      FuelRecord,
      $$FuelRecordsTableFilterComposer,
      $$FuelRecordsTableOrderingComposer,
      $$FuelRecordsTableAnnotationComposer,
      $$FuelRecordsTableCreateCompanionBuilder,
      $$FuelRecordsTableUpdateCompanionBuilder,
      (FuelRecord, $$FuelRecordsTableReferences),
      FuelRecord,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$MaintenanceTypesTableCreateCompanionBuilder =
    MaintenanceTypesCompanion Function({
      Value<int> id,
      required String name,
      Value<double?> recommendedIntervalKm,
      Value<int?> recommendedIntervalMonths,
    });
typedef $$MaintenanceTypesTableUpdateCompanionBuilder =
    MaintenanceTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double?> recommendedIntervalKm,
      Value<int?> recommendedIntervalMonths,
    });

final class $$MaintenanceTypesTableReferences
    extends
        BaseReferences<_$AppDatabase, $MaintenanceTypesTable, MaintenanceType> {
  $$MaintenanceTypesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MaintenanceTable, List<MaintenanceData>>
  _maintenanceRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenance,
    aliasName: $_aliasNameGenerator(
      db.maintenanceTypes.id,
      db.maintenance.typeId,
    ),
  );

  $$MaintenanceTableProcessedTableManager get maintenanceRefs {
    final manager = $$MaintenanceTableTableManager(
      $_db,
      $_db.maintenance,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_maintenanceRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaintenanceTypesTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceTypesTable> {
  $$MaintenanceTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get recommendedIntervalKm => $composableBuilder(
    column: $table.recommendedIntervalKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recommendedIntervalMonths => $composableBuilder(
    column: $table.recommendedIntervalMonths,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> maintenanceRefs(
    Expression<bool> Function($$MaintenanceTableFilterComposer f) f,
  ) {
    final $$MaintenanceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenance,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTableFilterComposer(
            $db: $db,
            $table: $db.maintenance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceTypesTable> {
  $$MaintenanceTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get recommendedIntervalKm => $composableBuilder(
    column: $table.recommendedIntervalKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recommendedIntervalMonths => $composableBuilder(
    column: $table.recommendedIntervalMonths,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaintenanceTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceTypesTable> {
  $$MaintenanceTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get recommendedIntervalKm => $composableBuilder(
    column: $table.recommendedIntervalKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recommendedIntervalMonths => $composableBuilder(
    column: $table.recommendedIntervalMonths,
    builder: (column) => column,
  );

  Expression<T> maintenanceRefs<T extends Object>(
    Expression<T> Function($$MaintenanceTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenance,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceTypesTable,
          MaintenanceType,
          $$MaintenanceTypesTableFilterComposer,
          $$MaintenanceTypesTableOrderingComposer,
          $$MaintenanceTypesTableAnnotationComposer,
          $$MaintenanceTypesTableCreateCompanionBuilder,
          $$MaintenanceTypesTableUpdateCompanionBuilder,
          (MaintenanceType, $$MaintenanceTypesTableReferences),
          MaintenanceType,
          PrefetchHooks Function({bool maintenanceRefs})
        > {
  $$MaintenanceTypesTableTableManager(
    _$AppDatabase db,
    $MaintenanceTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> recommendedIntervalKm = const Value.absent(),
                Value<int?> recommendedIntervalMonths = const Value.absent(),
              }) => MaintenanceTypesCompanion(
                id: id,
                name: name,
                recommendedIntervalKm: recommendedIntervalKm,
                recommendedIntervalMonths: recommendedIntervalMonths,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<double?> recommendedIntervalKm = const Value.absent(),
                Value<int?> recommendedIntervalMonths = const Value.absent(),
              }) => MaintenanceTypesCompanion.insert(
                id: id,
                name: name,
                recommendedIntervalKm: recommendedIntervalKm,
                recommendedIntervalMonths: recommendedIntervalMonths,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({maintenanceRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (maintenanceRefs) db.maintenance],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (maintenanceRefs)
                    await $_getPrefetchedData<
                      MaintenanceType,
                      $MaintenanceTypesTable,
                      MaintenanceData
                    >(
                      currentTable: table,
                      referencedTable: $$MaintenanceTypesTableReferences
                          ._maintenanceRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MaintenanceTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).maintenanceRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.typeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceTypesTable,
      MaintenanceType,
      $$MaintenanceTypesTableFilterComposer,
      $$MaintenanceTypesTableOrderingComposer,
      $$MaintenanceTypesTableAnnotationComposer,
      $$MaintenanceTypesTableCreateCompanionBuilder,
      $$MaintenanceTypesTableUpdateCompanionBuilder,
      (MaintenanceType, $$MaintenanceTypesTableReferences),
      MaintenanceType,
      PrefetchHooks Function({bool maintenanceRefs})
    >;
typedef $$MaintenanceTableCreateCompanionBuilder =
    MaintenanceCompanion Function({
      Value<int> id,
      required int vehicleId,
      Value<int?> typeId,
      required DateTime date,
      Value<double?> odometerKm,
      required String title,
      required int cost,
      Value<DateTime?> nextDueDate,
      Value<double?> nextDueKm,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$MaintenanceTableUpdateCompanionBuilder =
    MaintenanceCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<int?> typeId,
      Value<DateTime> date,
      Value<double?> odometerKm,
      Value<String> title,
      Value<int> cost,
      Value<DateTime?> nextDueDate,
      Value<double?> nextDueKm,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$MaintenanceTableReferences
    extends BaseReferences<_$AppDatabase, $MaintenanceTable, MaintenanceData> {
  $$MaintenanceTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.maintenance.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MaintenanceTypesTable _typeIdTable(_$AppDatabase db) =>
      db.maintenanceTypes.createAlias(
        $_aliasNameGenerator(db.maintenance.typeId, db.maintenanceTypes.id),
      );

  $$MaintenanceTypesTableProcessedTableManager? get typeId {
    final $_column = $_itemColumn<int>('type_id');
    if ($_column == null) return null;
    final manager = $$MaintenanceTypesTableTableManager(
      $_db,
      $_db.maintenanceTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenanceTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceTable> {
  $$MaintenanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get nextDueKm => $composableBuilder(
    column: $table.nextDueKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTypesTableFilterComposer get typeId {
    final $$MaintenanceTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.maintenanceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTypesTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceTable> {
  $$MaintenanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get nextDueKm => $composableBuilder(
    column: $table.nextDueKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTypesTableOrderingComposer get typeId {
    final $$MaintenanceTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.maintenanceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTypesTableOrderingComposer(
            $db: $db,
            $table: $db.maintenanceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceTable> {
  $$MaintenanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get nextDueKm =>
      $composableBuilder(column: $table.nextDueKm, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTypesTableAnnotationComposer get typeId {
    final $$MaintenanceTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.maintenanceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenanceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceTable,
          MaintenanceData,
          $$MaintenanceTableFilterComposer,
          $$MaintenanceTableOrderingComposer,
          $$MaintenanceTableAnnotationComposer,
          $$MaintenanceTableCreateCompanionBuilder,
          $$MaintenanceTableUpdateCompanionBuilder,
          (MaintenanceData, $$MaintenanceTableReferences),
          MaintenanceData,
          PrefetchHooks Function({bool vehicleId, bool typeId})
        > {
  $$MaintenanceTableTableManager(_$AppDatabase db, $MaintenanceTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<int?> typeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double?> odometerKm = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> cost = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<double?> nextDueKm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MaintenanceCompanion(
                id: id,
                vehicleId: vehicleId,
                typeId: typeId,
                date: date,
                odometerKm: odometerKm,
                title: title,
                cost: cost,
                nextDueDate: nextDueDate,
                nextDueKm: nextDueKm,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                Value<int?> typeId = const Value.absent(),
                required DateTime date,
                Value<double?> odometerKm = const Value.absent(),
                required String title,
                required int cost,
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<double?> nextDueKm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MaintenanceCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                typeId: typeId,
                date: date,
                odometerKm: odometerKm,
                title: title,
                cost: cost,
                nextDueDate: nextDueDate,
                nextDueKm: nextDueKm,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false, typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$MaintenanceTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$MaintenanceTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (typeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.typeId,
                                referencedTable: $$MaintenanceTableReferences
                                    ._typeIdTable(db),
                                referencedColumn: $$MaintenanceTableReferences
                                    ._typeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceTable,
      MaintenanceData,
      $$MaintenanceTableFilterComposer,
      $$MaintenanceTableOrderingComposer,
      $$MaintenanceTableAnnotationComposer,
      $$MaintenanceTableCreateCompanionBuilder,
      $$MaintenanceTableUpdateCompanionBuilder,
      (MaintenanceData, $$MaintenanceTableReferences),
      MaintenanceData,
      PrefetchHooks Function({bool vehicleId, bool typeId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String category,
      required int amount,
      required DateTime date,
      Value<String?> description,
      Value<DateTime> createdAt,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> category,
      Value<int> amount,
      Value<DateTime> date,
      Value<String?> description,
      Value<DateTime> createdAt,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) => db.vehicles
      .createAlias($_aliasNameGenerator(db.expenses.vehicleId, db.vehicles.id));

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                vehicleId: vehicleId,
                category: category,
                amount: amount,
                date: date,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String category,
                required int amount,
                required DateTime date,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                category: category,
                amount: amount,
                date: date,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$ExpensesTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$ExpensesTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String docType,
      required String name,
      Value<String?> number,
      Value<DateTime?> issueDate,
      required DateTime expiryDate,
      Value<String?> filePath,
      Value<int> reminderDays,
      Value<DateTime> createdAt,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> docType,
      Value<String> name,
      Value<String?> number,
      Value<DateTime?> issueDate,
      Value<DateTime> expiryDate,
      Value<String?> filePath,
      Value<int> reminderDays,
      Value<DateTime> createdAt,
    });

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.documents.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get docType => $composableBuilder(
    column: $table.docType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get docType => $composableBuilder(
    column: $table.docType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get docType =>
      $composableBuilder(column: $table.docType, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> docType = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<DateTime?> issueDate = const Value.absent(),
                Value<DateTime> expiryDate = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<int> reminderDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                vehicleId: vehicleId,
                docType: docType,
                name: name,
                number: number,
                issueDate: issueDate,
                expiryDate: expiryDate,
                filePath: filePath,
                reminderDays: reminderDays,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String docType,
                required String name,
                Value<String?> number = const Value.absent(),
                Value<DateTime?> issueDate = const Value.absent(),
                required DateTime expiryDate,
                Value<String?> filePath = const Value.absent(),
                Value<int> reminderDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                docType: docType,
                name: name,
                number: number,
                issueDate: issueDate,
                expiryDate: expiryDate,
                filePath: filePath,
                reminderDays: reminderDays,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$DocumentsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$DocumentsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$InsuranceTableCreateCompanionBuilder =
    InsuranceCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String provider,
      Value<String?> policyNumber,
      Value<String?> coverage,
      Value<DateTime?> startDate,
      required DateTime endDate,
      Value<int?> premium,
      Value<int> reminderDays,
      Value<DateTime> createdAt,
    });
typedef $$InsuranceTableUpdateCompanionBuilder =
    InsuranceCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> provider,
      Value<String?> policyNumber,
      Value<String?> coverage,
      Value<DateTime?> startDate,
      Value<DateTime> endDate,
      Value<int?> premium,
      Value<int> reminderDays,
      Value<DateTime> createdAt,
    });

final class $$InsuranceTableReferences
    extends BaseReferences<_$AppDatabase, $InsuranceTable, InsuranceData> {
  $$InsuranceTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.insurance.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InsuranceTableFilterComposer
    extends Composer<_$AppDatabase, $InsuranceTable> {
  $$InsuranceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverage => $composableBuilder(
    column: $table.coverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get premium => $composableBuilder(
    column: $table.premium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InsuranceTableOrderingComposer
    extends Composer<_$AppDatabase, $InsuranceTable> {
  $$InsuranceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverage => $composableBuilder(
    column: $table.coverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get premium => $composableBuilder(
    column: $table.premium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InsuranceTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsuranceTable> {
  $$InsuranceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverage =>
      $composableBuilder(column: $table.coverage, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get premium =>
      $composableBuilder(column: $table.premium, builder: (column) => column);

  GeneratedColumn<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InsuranceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InsuranceTable,
          InsuranceData,
          $$InsuranceTableFilterComposer,
          $$InsuranceTableOrderingComposer,
          $$InsuranceTableAnnotationComposer,
          $$InsuranceTableCreateCompanionBuilder,
          $$InsuranceTableUpdateCompanionBuilder,
          (InsuranceData, $$InsuranceTableReferences),
          InsuranceData,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$InsuranceTableTableManager(_$AppDatabase db, $InsuranceTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsuranceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsuranceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsuranceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> coverage = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<int?> premium = const Value.absent(),
                Value<int> reminderDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InsuranceCompanion(
                id: id,
                vehicleId: vehicleId,
                provider: provider,
                policyNumber: policyNumber,
                coverage: coverage,
                startDate: startDate,
                endDate: endDate,
                premium: premium,
                reminderDays: reminderDays,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String provider,
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> coverage = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                required DateTime endDate,
                Value<int?> premium = const Value.absent(),
                Value<int> reminderDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InsuranceCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                provider: provider,
                policyNumber: policyNumber,
                coverage: coverage,
                startDate: startDate,
                endDate: endDate,
                premium: premium,
                reminderDays: reminderDays,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InsuranceTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$InsuranceTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$InsuranceTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InsuranceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InsuranceTable,
      InsuranceData,
      $$InsuranceTableFilterComposer,
      $$InsuranceTableOrderingComposer,
      $$InsuranceTableAnnotationComposer,
      $$InsuranceTableCreateCompanionBuilder,
      $$InsuranceTableUpdateCompanionBuilder,
      (InsuranceData, $$InsuranceTableReferences),
      InsuranceData,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$TaxesTableCreateCompanionBuilder =
    TaxesCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String taxType,
      required int amount,
      required DateTime dueDate,
      Value<DateTime?> paidDate,
      Value<int> reminderDays,
      Value<DateTime> createdAt,
    });
typedef $$TaxesTableUpdateCompanionBuilder =
    TaxesCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> taxType,
      Value<int> amount,
      Value<DateTime> dueDate,
      Value<DateTime?> paidDate,
      Value<int> reminderDays,
      Value<DateTime> createdAt,
    });

final class $$TaxesTableReferences
    extends BaseReferences<_$AppDatabase, $TaxesTable, Taxe> {
  $$TaxesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) => db.vehicles
      .createAlias($_aliasNameGenerator(db.taxes.vehicleId, db.vehicles.id));

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TaxesTableFilterComposer extends Composer<_$AppDatabase, $TaxesTable> {
  $$TaxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxType => $composableBuilder(
    column: $table.taxType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaxesTableOrderingComposer
    extends Composer<_$AppDatabase, $TaxesTable> {
  $$TaxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxType => $composableBuilder(
    column: $table.taxType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaxesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaxesTable> {
  $$TaxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taxType =>
      $composableBuilder(column: $table.taxType, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get paidDate =>
      $composableBuilder(column: $table.paidDate, builder: (column) => column);

  GeneratedColumn<int> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaxesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaxesTable,
          Taxe,
          $$TaxesTableFilterComposer,
          $$TaxesTableOrderingComposer,
          $$TaxesTableAnnotationComposer,
          $$TaxesTableCreateCompanionBuilder,
          $$TaxesTableUpdateCompanionBuilder,
          (Taxe, $$TaxesTableReferences),
          Taxe,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$TaxesTableTableManager(_$AppDatabase db, $TaxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> taxType = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                Value<int> reminderDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TaxesCompanion(
                id: id,
                vehicleId: vehicleId,
                taxType: taxType,
                amount: amount,
                dueDate: dueDate,
                paidDate: paidDate,
                reminderDays: reminderDays,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String taxType,
                required int amount,
                required DateTime dueDate,
                Value<DateTime?> paidDate = const Value.absent(),
                Value<int> reminderDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TaxesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                taxType: taxType,
                amount: amount,
                dueDate: dueDate,
                paidDate: paidDate,
                reminderDays: reminderDays,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TaxesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$TaxesTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$TaxesTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TaxesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaxesTable,
      Taxe,
      $$TaxesTableFilterComposer,
      $$TaxesTableOrderingComposer,
      $$TaxesTableAnnotationComposer,
      $$TaxesTableCreateCompanionBuilder,
      $$TaxesTableUpdateCompanionBuilder,
      (Taxe, $$TaxesTableReferences),
      Taxe,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      Value<int?> vehicleId,
      required String type,
      required String title,
      Value<String?> body,
      Value<String?> relatedEntity,
      Value<int?> relatedId,
      Value<DateTime?> scheduledAt,
      Value<bool> isSent,
      Value<DateTime> createdAt,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      Value<int?> vehicleId,
      Value<String> type,
      Value<String> title,
      Value<String?> body,
      Value<String?> relatedEntity,
      Value<int?> relatedId,
      Value<DateTime?> scheduledAt,
      Value<bool> isSent,
      Value<DateTime> createdAt,
    });

final class $$NotificationsTableReferences
    extends BaseReferences<_$AppDatabase, $NotificationsTable, Notification> {
  $$NotificationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.notifications.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager? get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id');
    if ($_column == null) return null;
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedEntity => $composableBuilder(
    column: $table.relatedEntity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get relatedId => $composableBuilder(
    column: $table.relatedId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSent => $composableBuilder(
    column: $table.isSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedEntity => $composableBuilder(
    column: $table.relatedEntity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get relatedId => $composableBuilder(
    column: $table.relatedId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSent => $composableBuilder(
    column: $table.isSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get relatedEntity => $composableBuilder(
    column: $table.relatedEntity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get relatedId =>
      $composableBuilder(column: $table.relatedId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSent =>
      $composableBuilder(column: $table.isSent, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (Notification, $$NotificationsTableReferences),
          Notification,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> vehicleId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> relatedEntity = const Value.absent(),
                Value<int?> relatedId = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<bool> isSent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                vehicleId: vehicleId,
                type: type,
                title: title,
                body: body,
                relatedEntity: relatedEntity,
                relatedId: relatedId,
                scheduledAt: scheduledAt,
                isSent: isSent,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> vehicleId = const Value.absent(),
                required String type,
                required String title,
                Value<String?> body = const Value.absent(),
                Value<String?> relatedEntity = const Value.absent(),
                Value<int?> relatedId = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<bool> isSent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => NotificationsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                type: type,
                title: title,
                body: body,
                relatedEntity: relatedEntity,
                relatedId: relatedId,
                scheduledAt: scheduledAt,
                isSent: isSent,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NotificationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$NotificationsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$NotificationsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (Notification, $$NotificationsTableReferences),
      Notification,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      required String entityType,
      required int entityId,
      required String path,
      Value<String?> mimeType,
      Value<DateTime> createdAt,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<int> entityId,
      Value<String> path,
      Value<String?> mimeType,
      Value<DateTime> createdAt,
    });

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          Attachment,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (
            Attachment,
            BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment>,
          ),
          Attachment,
          PrefetchHooks Function()
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<int> entityId = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                path: path,
                mimeType: mimeType,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required int entityId,
                required String path,
                Value<String?> mimeType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                path: path,
                mimeType: mimeType,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      Attachment,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (
        Attachment,
        BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment>,
      ),
      Attachment,
      PrefetchHooks Function()
    >;
typedef $$ActivityLogsTableCreateCompanionBuilder =
    ActivityLogsCompanion Function({
      Value<int> id,
      required String action,
      required String entityType,
      Value<int?> entityId,
      Value<String?> detail,
      Value<DateTime> createdAt,
    });
typedef $$ActivityLogsTableUpdateCompanionBuilder =
    ActivityLogsCompanion Function({
      Value<int> id,
      Value<String> action,
      Value<String> entityType,
      Value<int?> entityId,
      Value<String?> detail,
      Value<DateTime> createdAt,
    });

class $$ActivityLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ActivityLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityLogsTable,
          ActivityLog,
          $$ActivityLogsTableFilterComposer,
          $$ActivityLogsTableOrderingComposer,
          $$ActivityLogsTableAnnotationComposer,
          $$ActivityLogsTableCreateCompanionBuilder,
          $$ActivityLogsTableUpdateCompanionBuilder,
          (
            ActivityLog,
            BaseReferences<_$AppDatabase, $ActivityLogsTable, ActivityLog>,
          ),
          ActivityLog,
          PrefetchHooks Function()
        > {
  $$ActivityLogsTableTableManager(_$AppDatabase db, $ActivityLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<int?> entityId = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ActivityLogsCompanion(
                id: id,
                action: action,
                entityType: entityType,
                entityId: entityId,
                detail: detail,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String action,
                required String entityType,
                Value<int?> entityId = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ActivityLogsCompanion.insert(
                id: id,
                action: action,
                entityType: entityType,
                entityId: entityId,
                detail: detail,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityLogsTable,
      ActivityLog,
      $$ActivityLogsTableFilterComposer,
      $$ActivityLogsTableOrderingComposer,
      $$ActivityLogsTableAnnotationComposer,
      $$ActivityLogsTableCreateCompanionBuilder,
      $$ActivityLogsTableUpdateCompanionBuilder,
      (
        ActivityLog,
        BaseReferences<_$AppDatabase, $ActivityLogsTable, ActivityLog>,
      ),
      ActivityLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$FuelRecordsTableTableManager get fuelRecords =>
      $$FuelRecordsTableTableManager(_db, _db.fuelRecords);
  $$MaintenanceTypesTableTableManager get maintenanceTypes =>
      $$MaintenanceTypesTableTableManager(_db, _db.maintenanceTypes);
  $$MaintenanceTableTableManager get maintenance =>
      $$MaintenanceTableTableManager(_db, _db.maintenance);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$InsuranceTableTableManager get insurance =>
      $$InsuranceTableTableManager(_db, _db.insurance);
  $$TaxesTableTableManager get taxes =>
      $$TaxesTableTableManager(_db, _db.taxes);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$ActivityLogsTableTableManager get activityLogs =>
      $$ActivityLogsTableTableManager(_db, _db.activityLogs);
}
