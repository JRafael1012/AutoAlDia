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

  /// Ruta temporal de la foto recién seleccionada con `image_picker`.
  /// Se persiste (mueve) a `vehicles/{id}/photos/` al guardar.
  final String? selectedImagePath;

  /// Foto ya almacenada (modo edición), para mostrarla si no se cambió.
  final String? existingPhotoPath;

  final bool submitting;
  final String? errorMessage;
  final bool completed;

  /// Ruta de imagen a mostrar: la recién elegida o la existente.
  String? get displayPhotoPath => selectedImagePath ?? existingPhotoPath;

  VehicleFormState copyWith({
    String? brand,
    String? model,
    String? year,
    String? plate,
    String? odometerKm,
    String? fuelType,
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
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      existingPhotoPath: existingPhotoPath ?? this.existingPhotoPath,
      submitting: submitting ?? this.submitting,
      errorMessage: errorMessage ?? this.errorMessage,
      completed: completed ?? this.completed,
    );
  }
}
