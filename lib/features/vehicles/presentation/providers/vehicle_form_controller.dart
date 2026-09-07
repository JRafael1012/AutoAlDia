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
    return brandError ??
        modelError ??
        yearError ??
        plateError ??
        odometerError ??
        fuelError;
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
        );
      }

      // 2. Persistir la foto nueva si se seleccionó una, o limpiar si se quitó.
      final newPhoto = state.selectedImagePath;
      final removedExisting = state.existingPhotoPath?.isEmpty ?? false;
      if (newPhoto != null && newPhoto.isNotEmpty) {
        final file = await storage.saveVehiclePhoto(
          vehicleId: saved.id,
          sourceFile: File(newPhoto),
        );
        saved = await repo.update(id: saved.id, photoPath: file.path);
      } else if (removedExisting && (saved.photoPath?.isNotEmpty ?? false)) {
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
}
