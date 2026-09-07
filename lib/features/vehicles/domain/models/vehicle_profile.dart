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
    this.tankCapacity,
    this.acquisitionDate,
    this.purchaseValue,
    this.currentEstimatedValue,
    this.color,
    this.vin,
    this.vehicleType,
    this.observations,
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

  /// Capacidad del tanque en litros (opcional).
  final double? tankCapacity;

  /// Fecha de adquisición (opcional).
  final DateTime? acquisitionDate;

  /// Valor de compra en unidad mínima de la moneda (COP).
  final int? purchaseValue;

  /// Valor actual estimado en unidad mínima de la moneda (COP).
  final int? currentEstimatedValue;

  /// Color del vehículo (opcional).
  final String? color;

  /// Número de identificación vehicular (VIN) (opcional).
  final String? vin;

  /// carro | moto | camioneta | otro.
  final String? vehicleType;

  /// Observaciones o notas libres (opcional).
  final String? observations;

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

  /// Opciones válidas de tipo de vehículo.
  static const List<String> vehicleTypes = [
    'carro',
    'moto',
    'camioneta',
    'otro',
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

  /// Nombre legible del tipo de vehículo.
  String get vehicleTypeLabel {
    return switch (vehicleType) {
      'carro' => 'Carro',
      'moto' => 'Moto',
      'camioneta' => 'Camioneta',
      'otro' => 'Otro',
      _ => vehicleType ?? '',
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
    double? tankCapacity,
    DateTime? acquisitionDate,
    int? purchaseValue,
    int? currentEstimatedValue,
    String? color,
    String? vin,
    String? vehicleType,
    String? observations,
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
      tankCapacity: tankCapacity ?? this.tankCapacity,
      acquisitionDate: acquisitionDate ?? this.acquisitionDate,
      purchaseValue: purchaseValue ?? this.purchaseValue,
      currentEstimatedValue: currentEstimatedValue ?? this.currentEstimatedValue,
      color: color ?? this.color,
      vin: vin ?? this.vin,
      vehicleType: vehicleType ?? this.vehicleType,
      observations: observations ?? this.observations,
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
          tankCapacity == other.tankCapacity &&
          acquisitionDate == other.acquisitionDate &&
          purchaseValue == other.purchaseValue &&
          currentEstimatedValue == other.currentEstimatedValue &&
          color == other.color &&
          vin == other.vin &&
          vehicleType == other.vehicleType &&
          observations == other.observations &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hashAll([
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
        tankCapacity,
        acquisitionDate,
        purchaseValue,
        currentEstimatedValue,
        color,
        vin,
        vehicleType,
        observations,
        createdAt,
        updatedAt,
      ]);

  @override
  String toString() =>
      'VehicleProfile(id: $id, brand: $brand, model: $model, plate: $plate)';
}
