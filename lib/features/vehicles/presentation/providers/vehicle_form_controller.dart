import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/storage/storage_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/models/vehicle_profile.dart';
import '../../domain/vehicle_validator.dart';
import 'vehicle_form_state.dart';
import 'vehicle_providers.dart';

part 'vehicle_form_controller.g.dart';

/// Controlador del formulario de vehículo (crear y editar).
///
/// Mantiene el estado del formulario + validaciones + guardado en un solo
/// lugar testeable, siguiendo el patrón de `ProfileSetupController`.
@Riverpod(keepAlive: true)
class VehicleFormController extends _$VehicleFormController {
  static const _validator = VehicleValidator();

  /// Id del vehículo en modo edición (null = creación).
  int? _editingId;

  @override
  VehicleFormState build() => const VehicleFormState();

  /// Id del vehículo que se está editando, o null si es creación.
  int? get editingId => _editingId;

  /// Prepara el formulario para crear un vehículo nuevo.
  void startCreate() {
    _editingId = null;
    state = const VehicleFormState();
  }

  /// Prepara el formulario para editar un vehículo existente.
  void startEdit(VehicleProfile vehicle) {
    _editingId = vehicle.id;
    state = VehicleFormState(
      brand: vehicle.brand,
      model: vehicle.model,
      year: vehicle.year?.toString() ?? '',
      plate: vehicle.plate ?? '',
      odometerKm: _formatOdometer(vehicle.odometerKm),
      fuelType: vehicle.fuelType,
      tankCapacity: vehicle.tankCapacity?.toString() ?? '',
      acquisitionDate:
          vehicle.acquisitionDate == null ? '' : _formatDate(vehicle.acquisitionDate!),
      purchaseValue: vehicle.purchaseValue?.toString() ?? '',
      currentEstimatedValue: vehicle.currentEstimatedValue?.toString() ?? '',
      color: vehicle.color ?? '',
      vin: vehicle.vin ?? '',
      vehicleType: vehicle.vehicleType ?? '',
      observations: vehicle.observations ?? '',
      existingPhotoPath: vehicle.photoPath,
    );
  }

  void setBrand(String value) =>
      state = state.copyWith(brand: value, errorMessage: null);
  void setModel(String value) =>
      state = state.copyWith(model: value, errorMessage: null);
  void setYear(String value) =>
      state = state.copyWith(year: value, errorMessage: null);
  void setPlate(String value) =>
      state = state.copyWith(plate: value, errorMessage: null);
  void setOdometer(String value) =>
      state = state.copyWith(odometerKm: value, errorMessage: null);
  void setFuelType(String value) =>
      state = state.copyWith(fuelType: value, errorMessage: null);
  void setTankCapacity(String value) =>
      state = state.copyWith(tankCapacity: value, errorMessage: null);
  void setAcquisitionDate(String value) =>
      state = state.copyWith(acquisitionDate: value, errorMessage: null);
  void setPurchaseValue(String value) =>
      state = state.copyWith(purchaseValue: value, errorMessage: null);
  void setCurrentEstimatedValue(String value) =>
      state = state.copyWith(currentEstimatedValue: value, errorMessage: null);
  void setColor(String value) =>
      state = state.copyWith(color: value, errorMessage: null);
  void setVin(String value) =>
      state = state.copyWith(vin: value, errorMessage: null);
  void setVehicleType(String value) =>
      state = state.copyWith(vehicleType: value, errorMessage: null);
  void setObservations(String value) =>
      state = state.copyWith(observations: value, errorMessage: null);

  /// Guarda el path de la foto recién seleccionada con `image_picker`.
  void setSelectedImagePath(String? path) =>
      state = state.copyWith(selectedImagePath: path, errorMessage: null);

  /// Quita la foto actual (tanto la recién elegida como la existente).
  void removePhoto() =>
      state = state.copyWith(selectedImagePath: '', existingPhotoPath: '');

  /// Valida el formulario campo por campo y devuelve el primer error o null.
  String? validateForm() {
    final brandError = _validator.validateBrand(state.brand);
    final modelError = _validator.validateModel(state.model);
    final yearError = _validator.validateYear(state.year);
    final plateError = _validator.validatePlate(state.plate);
    final odometerError = _validator.validateOdometer(state.odometerKm);
    final fuelError = _validator.validateFuelType(state.fuelType);
    final tankCapacityError = _validator.validateTankCapacity(state.tankCapacity);
    final acquisitionDateError = _validator.validateAcquisitionDate(state.acquisitionDate);
    final purchaseValueError = _validator.validatePurchaseValue(state.purchaseValue);
    final currentValueError =
        _validator.validateCurrentEstimatedValue(state.currentEstimatedValue);
    final colorError = _validator.validateColor(state.color);
    final vinError = _validator.validateVin(state.vin);
    final vehicleTypeError = _validator.validateVehicleType(state.vehicleType);
    final observationsError = _validator.validateObservations(state.observations);
    return brandError ??
        modelError ??
        yearError ??
        plateError ??
        odometerError ??
        fuelError ??
        tankCapacityError ??
        acquisitionDateError ??
        purchaseValueError ??
        currentValueError ??
        colorError ??
        vinError ??
        vehicleTypeError ??
        observationsError;
  }

  /// Valida la regla de placa única por usuario antes de guardar.
  Future<String?> _validateUniquePlate() async {
    final plate = state.plate.trim();
    if (plate.isEmpty) return null;

    final user = await ref.read(profileControllerProvider.future);
    if (user == null) return null;

    final existing =
        await ref.read(vehicleRepositoryProvider).findByPlate(user.id, plate);
    if (existing == null) return null;

    // Permitir guardar si la placa coincide con el propio vehículo en edición.
    if (existing.id == editingId) return null;
    return 'Ya existe un vehículo con la placa $plate.';
  }

  /// Guarda el vehículo (crea o actualiza) y persiste la foto si cambió.
  Future<bool> save() async {
    final validationError = validateForm();
    if (validationError != null) {
      state = state.copyWith(errorMessage: validationError);
      return false;
    }

    final plateError = await _validateUniquePlate();
    if (plateError != null) {
      state = state.copyWith(errorMessage: plateError);
      return false;
    }

    final user = await ref.read(profileControllerProvider.future);
    if (user == null) {
      state = state.copyWith(errorMessage: 'No hay un perfil configurado.');
      return false;
    }

    state = state.copyWith(submitting: true, errorMessage: null);
    try {
      final repo = ref.read(vehicleRepositoryProvider);
      final storage = ref.read(localStorageServiceProvider);
      final id = _editingId;
      final odometer = double.parse(state.odometerKm.trim());
      final yearTxt = state.year.trim();
      final year = yearTxt.isEmpty ? null : int.parse(yearTxt);
      final plate = state.plate.trim().isEmpty ? null : state.plate.trim();

      // Datos adicionales (opcionales): vacío → null.
      final tankCapacity = state.tankCapacity.trim().isEmpty
          ? null
          : double.parse(state.tankCapacity.trim());
      final acquisitionDate = _parseDate(state.acquisitionDate);
      final purchaseValue =
          state.purchaseValue.trim().isEmpty ? null : int.parse(state.purchaseValue.trim());
      final currentEstimatedValue = state.currentEstimatedValue.trim().isEmpty
          ? null
          : int.parse(state.currentEstimatedValue.trim());

      VehicleProfile saved;
      if (id == null) {
        // 1. Crear el vehículo (el primero queda activo automáticamente).
        saved = await repo.create(
          userId: user.id,
          brand: state.brand,
          model: state.model,
          odometerKm: odometer,
          fuelType: state.fuelType,
          year: year,
          plate: plate,
          tankCapacity: tankCapacity,
          acquisitionDate: acquisitionDate,
          purchaseValue: purchaseValue,
          currentEstimatedValue: currentEstimatedValue,
          color: state.color,
          vin: state.vin,
          vehicleType: state.vehicleType,
          observations: state.observations,
        );
      } else {
        saved = await repo.update(
          id: id,
          brand: state.brand,
          model: state.model,
          year: year,
          plate: plate,
          odometerKm: odometer,
          fuelType: state.fuelType,
          tankCapacity: tankCapacity,
          acquisitionDate: acquisitionDate,
          purchaseValue: purchaseValue,
          currentEstimatedValue: currentEstimatedValue,
          color: state.color,
          vin: state.vin,
          vehicleType: state.vehicleType,
          observations: state.observations,
        );
      }

      // 2. Persistir la foto nueva si se seleccionó una, o limpiar si se quitó.
      //    Se guarda la RUTA RELATIVA (vehicles/{id}/photos/...) y la absoluta
      //    se reconstruye en tiempo de ejecución (ver LocalStorageService).
      final newPhoto = state.selectedImagePath;
      final removedExisting = state.existingPhotoPath == '';

      if (newPhoto != null && newPhoto.isNotEmpty) {
        // M4: eliminar la foto anterior antes de guardar la nueva para no
        // dejar archivos huérfanos al reemplazarla.
        if (state.existingPhotoPath?.isNotEmpty ?? false) {
          await ref
              .read(localStorageServiceProvider)
              .deleteRelativeFile(state.existingPhotoPath!);
        }
        final relativePath = await storage.saveVehiclePhoto(
          vehicleId: saved.id,
          sourceFile: File(newPhoto),
        );
        saved = await repo.update(id: saved.id, photoPath: relativePath);
      } else if (removedExisting && (saved.photoPath?.isNotEmpty ?? false)) {
        // M4: al quitar la foto, eliminar también el archivo físico.
        await ref
            .read(localStorageServiceProvider)
            .deleteRelativeFile(saved.photoPath!);
        saved = await repo.update(id: saved.id, photoPath: '');
      }

      // 3. Refrescar la lista y el vehículo activo.
      ref.invalidate(vehiclesListControllerProvider);
      ref.invalidate(activeVehicleControllerProvider);

      // 4. Recargar el estado del formulario con los datos guardados.
      state = VehicleFormState(
        brand: saved.brand,
        model: saved.model,
        year: saved.year?.toString() ?? '',
        plate: saved.plate ?? '',
        odometerKm: _formatOdometer(saved.odometerKm),
        fuelType: saved.fuelType,
        tankCapacity: saved.tankCapacity?.toString() ?? '',
        acquisitionDate: saved.acquisitionDate == null
            ? ''
            : _formatDate(saved.acquisitionDate!),
        purchaseValue: saved.purchaseValue?.toString() ?? '',
        currentEstimatedValue: saved.currentEstimatedValue?.toString() ?? '',
        color: saved.color ?? '',
        vin: saved.vin ?? '',
        vehicleType: saved.vehicleType ?? '',
        observations: saved.observations ?? '',
        existingPhotoPath: saved.photoPath,
        submitting: false,
        completed: true,
      );
      return true;
    } on AppFailure catch (e) {
      state = state.copyWith(submitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        submitting: false,
        errorMessage: 'Ocurrió un error inesperado. Intenta de nuevo.',
      );
      return false;
    }
  }

  static String _formatOdometer(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toString();
  }

  /// Formatea una fecha como `yyyy-MM-dd` para usar en campos de texto.
  static String _formatDate(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  /// Parsea `yyyy-MM-dd` (o cualquier formato soportado) a [DateTime].
  static DateTime? _parseDate(String value) {
    final v = value.trim();
    return v.isEmpty ? null : DateTime.tryParse(v);
  }
}