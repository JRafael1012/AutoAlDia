/// Entidad pura de vehículo (sin dependencias de Drift ni Flutter).
///
/// Los valores posibles de `fuelType` y `status` se validan en la capa de
/// presentación; aquí se guardan como `String` para no acoplar el dominio
/// a un enum que puede crecer sin migración (decisión #6 del esquema).
class VehicleProfile {
  const VehicleProfile({
    required this.id,
    required this.userId,
    required this.brand,
    required this.model,
    required this.odometerKm,
    required this.fuelType,
    required this.status,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.year,
    this.plate,
    this.photoPath,
  });

  final int id;
  final int userId;
  final String brand;
  final String model;
  final int? year;
  final String? plate;
  final double odometerKm;
  final String fuelType;
  final String status;
  final String? photoPath;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Opciones válidas de tipo de combustible.
  static const List<String> fuelTypes = [
    'gasolina',
    'diesel',
    'electrico',
    'hibrido',
  ];

  /// Opciones válidas de estado del vehículo.
  static const List<String> statuses = [
    'activo',
    'inactivo',
    'vendido',
  ];

  /// Nombre legible del tipo de combustible.
  String get fuelTypeLabel {
    return switch (fuelType) {
      'gasolina' => 'Gasolina',
      'diesel' => 'Diésel',
      'electrico' => 'Eléctrico',
      'hibrido' => 'Híbrido',
      _ => fuelType,
    };
  }

  /// Nombre legible del estado.
  String get statusLabel {
    return switch (status) {
      'activo' => 'Activo',
      'inactivo' => 'Inactivo',
      'vendido' => 'Vendido',
      _ => status,
    };
  }

  VehicleProfile copyWith({
    String? brand,
    String? model,
    int? year,
    String? plate,
    double? odometerKm,
    String? fuelType,
    String? status,
    String? photoPath,
    bool? isActive,
  }) {
    return VehicleProfile(
      id: id,
      userId: userId,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      odometerKm: odometerKm ?? this.odometerKm,
      fuelType: fuelType ?? this.fuelType,
      status: status ?? this.status,
      photoPath: photoPath ?? this.photoPath,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleProfile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          brand == other.brand &&
          model == other.model &&
          year == other.year &&
          plate == other.plate &&
          odometerKm == other.odometerKm &&
          fuelType == other.fuelType &&
          status == other.status &&
          photoPath == other.photoPath &&
          isActive == other.isActive &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

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
  String toString() =>
      'VehicleProfile(id: $id, brand: $brand, model: $model, plate: $plate)';
}
