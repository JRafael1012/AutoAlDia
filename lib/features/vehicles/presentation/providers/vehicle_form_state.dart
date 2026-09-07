/// Estado del formulario de vehículo (crear o editar), local a la pantalla.
///
/// Sigue el patrón de `ProfileSetupState`: un `Notifier` local mantiene el
/// estado mutable del formulario y la lógica de envío en un solo lugar.
class VehicleFormState {
  const VehicleFormState({
    this.brand = '',
    this.model = '',
    this.year = '',
    this.plate = '',
    this.odometerKm = '',
    this.fuelType = '',
    this.tankCapacity = '',
    this.acquisitionDate = '',
    this.purchaseValue = '',
    this.currentEstimatedValue = '',
    this.color = '',
    this.vin = '',
    this.vehicleType = '',
    this.observations = '',
    this.selectedImagePath,
    this.existingPhotoPath,
    this.submitting = false,
    this.errorMessage,
    this.completed = false,
  });

  final String brand;
  final String model;
  final String year;
  final String plate;
  final String odometerKm;
  final String fuelType;

  // ── Datos adicionales (opcionales) ─────────────────────────────────────

  /// Capacidad del tanque en litros (texto libre, opcional).
  final String tankCapacity;

  /// Fecha de adquisición en formato `yyyy-MM-dd` (opcional).
  final String acquisitionDate;

  /// Valor de compra en enteros COP (texto libre, opcional).
  final String purchaseValue;

  /// Valor actual estimado en enteros COP (texto libre, opcional).
  final String currentEstimatedValue;

  /// Color del vehículo (opcional).
  final String color;

  /// Número de identificación vehicular VIN (opcional).
  final String vin;

  /// Tipo de vehículo: carro | moto | camioneta | otro (opcional).
  final String vehicleType;

  /// Observaciones o notas libres (opcional).
  final String observations;

  /// Ruta temporal de la foto recién seleccionada con `image_picker`.
  /// Se persiste (mueve) a `vehicles/{id}/photos/` al guardar.
  final String? selectedImagePath;

  /// Foto ya almacenada (modo edición como ruta relativa), para mostrarla
  /// si no se cambió. Se resuelve a ruta absoluta en tiempo de ejecución.
  final String? existingPhotoPath;

  final bool submitting;
  final String? errorMessage;
  final bool completed;

  /// true si hay una foto recién seleccionada pendiente de guardar.
  bool get hasNewPhoto => selectedImagePath != null && selectedImagePath!.isNotEmpty;

  /// true si hay una foto almacenada (modo edición).
  bool get hasExistingPhoto => existingPhotoPath != null && existingPhotoPath!.isNotEmpty;

  VehicleFormState copyWith({
    String? brand,
    String? model,
    String? year,
    String? plate,
    String? odometerKm,
    String? fuelType,
    String? tankCapacity,
    String? acquisitionDate,
    String? purchaseValue,
    String? currentEstimatedValue,
    String? color,
    String? vin,
    String? vehicleType,
    String? observations,
    String? selectedImagePath,
    String? existingPhotoPath,
    bool? submitting,
    String? errorMessage,
    bool? completed,
  }) {
    return VehicleFormState(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      odometerKm: odometerKm ?? this.odometerKm,
      fuelType: fuelType ?? this.fuelType,
      tankCapacity: tankCapacity ?? this.tankCapacity,
      acquisitionDate: acquisitionDate ?? this.acquisitionDate,
      purchaseValue: purchaseValue ?? this.purchaseValue,
      currentEstimatedValue: currentEstimatedValue ?? this.currentEstimatedValue,
      color: color ?? this.color,
      vin: vin ?? this.vin,
      vehicleType: vehicleType ?? this.vehicleType,
      observations: observations ?? this.observations,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      existingPhotoPath: existingPhotoPath ?? this.existingPhotoPath,
      submitting: submitting ?? this.submitting,
      errorMessage: errorMessage ?? this.errorMessage,
      completed: completed ?? this.completed,
    );
  }
}