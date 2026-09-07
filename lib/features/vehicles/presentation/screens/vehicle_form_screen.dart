import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/storage/local_storage_service.dart';
import '../../../../core/storage/storage_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/models/vehicle_profile.dart';
import '../../domain/vehicle_validator.dart';
import '../providers/vehicle_form_controller.dart';
import '../providers/vehicle_form_state.dart';
import '../providers/vehicle_providers.dart';

/// Formulario de vehículo reutilizado para crear y editar.
///
/// Si se pasa [vehicleId], carga ese vehículo (edición); si no, crea uno nuevo.
class VehicleFormScreen extends ConsumerStatefulWidget {
  const VehicleFormScreen({super.key, this.vehicleId});

  final int? vehicleId;

  @override
  ConsumerState<VehicleFormScreen> createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends ConsumerState<VehicleFormScreen> {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    _ensureInitialized();
    final editing = widget.vehicleId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar vehículo' : 'Nuevo vehículo'),
      ),
      body: _VehicleFormBody(editingMode: editing),
    );
  }

  /// Prepara el formulario (crear o editar) después del primer frame.
  ///
  /// No se puede mutar un provider dentro de `build()` (Riverpod lo prohíbe),
  /// por eso la inicialización se difiere con [WidgetsBinding.addPostFrameCallback].
  void _ensureInitialized() {
    if (_initialized) return;

    if (widget.vehicleId == null) {
      _scheduleCreate();
      return;
    }

    // Modo edición: esperar a que la lista de vehículos esté cargada.
    final vehicles = ref.watch(vehiclesListControllerProvider).value;
    final vehicle =
        vehicles?.where((v) => v.id == widget.vehicleId).firstOrNull;
    if (vehicle != null) {
      _scheduleEdit(vehicle);
    }
    // Si la lista aún está cargando, seguirá intentándolo en cada build.
  }

  void _scheduleCreate() {
    _initialized = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(vehicleFormControllerProvider.notifier).startCreate();
    });
  }

  void _scheduleEdit(VehicleProfile vehicle) {
    _initialized = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(vehicleFormControllerProvider.notifier).startEdit(vehicle);
    });
  }
}

class _VehicleFormBody extends ConsumerStatefulWidget {
  const _VehicleFormBody({required this.editingMode});

  final bool editingMode;

  @override
  ConsumerState<_VehicleFormBody> createState() => _VehicleFormBodyState();
}

class _VehicleFormBodyState extends ConsumerState<_VehicleFormBody> {
  static const _validator = VehicleValidator();
  final _picker = ImagePicker();

  late final TextEditingController _brand;
  late final TextEditingController _model;
  late final TextEditingController _year;
  late final TextEditingController _plate;
  late final TextEditingController _odometer;
  late final TextEditingController _tankCapacity;
  late final TextEditingController _acquisitionDate;
  late final TextEditingController _purchaseValue;
  late final TextEditingController _currentEstimatedValue;
  late final TextEditingController _color;
  late final TextEditingController _vin;
  late final TextEditingController _observations;
  Map<String, String> _localErrors = {};

  @override
  void initState() {
    super.initState();
    final s = ref.read(vehicleFormControllerProvider);
    _brand = TextEditingController(text: s.brand);
    _model = TextEditingController(text: s.model);
    _year = TextEditingController(text: s.year);
    _plate = TextEditingController(text: s.plate);
    _odometer = TextEditingController(text: s.odometerKm);
    _tankCapacity = TextEditingController(text: s.tankCapacity);
    _acquisitionDate = TextEditingController(text: s.acquisitionDate);
    _purchaseValue = TextEditingController(text: s.purchaseValue);
    _currentEstimatedValue = TextEditingController(text: s.currentEstimatedValue);
    _color = TextEditingController(text: s.color);
    _vin = TextEditingController(text: s.vin);
    _observations = TextEditingController(text: s.observations);
  }

  @override
  void dispose() {
    _brand.dispose();
    _model.dispose();
    _year.dispose();
    _plate.dispose();
    _odometer.dispose();
    _tankCapacity.dispose();
    _acquisitionDate.dispose();
    _purchaseValue.dispose();
    _currentEstimatedValue.dispose();
    _color.dispose();
    _vin.dispose();
    _observations.dispose();
    super.dispose();
  }

  /// Mantiene los controladores de texto sincronizados con el estado del
  /// formulario (carga en edición, reset en creación, reset tras guardar).
  void _syncControllers(VehicleFormState state) {
    if (state.brand != _brand.text) _brand.text = state.brand;
    if (state.model != _model.text) _model.text = state.model;
    if (state.year != _year.text) _year.text = state.year;
    if (state.plate != _plate.text) _plate.text = state.plate;
    if (state.odometerKm != _odometer.text) _odometer.text = state.odometerKm;
    if (state.tankCapacity != _tankCapacity.text) {
      _tankCapacity.text = state.tankCapacity;
    }
    if (state.acquisitionDate != _acquisitionDate.text) {
      _acquisitionDate.text = state.acquisitionDate;
    }
    if (state.purchaseValue != _purchaseValue.text) {
      _purchaseValue.text = state.purchaseValue;
    }
    if (state.currentEstimatedValue != _currentEstimatedValue.text) {
      _currentEstimatedValue.text = state.currentEstimatedValue;
    }
    if (state.color != _color.text) _color.text = state.color;
    if (state.vin != _vin.text) _vin.text = state.vin;
    if (state.observations != _observations.text) {
      _observations.text = state.observations;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleFormControllerProvider);
    final controller = ref.read(vehicleFormControllerProvider.notifier);
    _syncControllers(state);

    final storage = ref.watch(localStorageServiceProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PhotoPickerSection(
            hasImage: state.hasNewPhoto || state.hasExistingPhoto,
            preview: _photoPreview(state, storage),
            loading: state.submitting,
            onPick: _pickPhoto,
            onRemove: (state.hasNewPhoto || state.hasExistingPhoto)
                ? () => controller.removePhoto()
                : null,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Marca *',
            hint: 'Ej. Toyota',
            controller: _brand,
            textInputAction: TextInputAction.next,
            errorText: _localErrors['brand'],
            onChanged: (v) {
              controller.setBrand(v);
              _clearError('brand');
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Modelo *',
            hint: 'Ej. Corolla',
            controller: _model,
            textInputAction: TextInputAction.next,
            errorText: _localErrors['model'],
            onChanged: (v) {
              controller.setModel(v);
              _clearError('model');
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Año',
                  hint: 'Ej. 2020',
                  controller: _year,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  errorText: _localErrors['year'],
                  onChanged: (v) {
                    controller.setYear(v);
                    _clearError('year');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppTextField(
                  label: 'Placa',
                  hint: 'ABC-123',
                  controller: _plate,
                  textInputAction: TextInputAction.next,
                  errorText: _localErrors['plate'],
                  onChanged: (v) {
                    controller.setPlate(v);
                    _clearError('plate');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Kilometraje actual *',
            hint: 'Ej. 45000',
            controller: _odometer,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            errorText: _localErrors['odometer'],
            onChanged: (v) {
              controller.setOdometer(v);
              _clearError('odometer');
            },
          ),
          const SizedBox(height: 16),
          _FuelTypeSelector(
            value: state.fuelType,
            errorText: _localErrors['fuelType'],
            onChanged: (v) {
              controller.setFuelType(v);
              _clearError('fuelType');
            },
          ),
          const SizedBox(height: 8),
          _AdditionalDataSection(
            controllers: _AdditionalDataControllers(
              tankCapacity: _tankCapacity,
              acquisitionDate: _acquisitionDate,
              purchaseValue: _purchaseValue,
              currentEstimatedValue: _currentEstimatedValue,
              color: _color,
              vin: _vin,
              observations: _observations,
            ),
            vehicleType: state.vehicleType,
            errors: _localErrors,
            onChanged: (field, value) {
              switch (field) {
                case 'tankCapacity':
                  controller.setTankCapacity(value);
                case 'acquisitionDate':
                  controller.setAcquisitionDate(value);
                case 'purchaseValue':
                  controller.setPurchaseValue(value);
                case 'currentEstimatedValue':
                  controller.setCurrentEstimatedValue(value);
                case 'color':
                  controller.setColor(value);
                case 'vin':
                  controller.setVin(value);
                case 'vehicleType':
                  controller.setVehicleType(value);
                case 'observations':
                  controller.setObservations(value);
              }
              _clearError(field);
            },
            onPickDate: _pickAcquisitionDate,
            onClearDate: () {
              controller.setAcquisitionDate('');
              _acquisitionDate.text = '';
            },
          ),
          if (state.errorMessage != null) ...[
            const SizedBox(height: 16),
            Text(
              state.errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 24),
          AppButton(
            text: widget.editingMode ? 'Guardar cambios' : 'Guardar vehículo',
            isLoading: state.submitting,
            onPressed: state.submitting ? null : () => _submit(controller),
          ),
        ],
      ),
    );
  }

  /// Construye la vista previa de la foto: la recién elegida se muestra
  /// directa (ruta temporal absoluta); la almacenada se resuelve desde su
  /// ruta relativa en tiempo de ejecución (convención M1).
  Widget? _photoPreview(VehicleFormState state, LocalStorageService storage) {
    if (state.hasNewPhoto) {
      return Image.file(
        File(state.selectedImagePath!),
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const _PhotoPlaceholder(),
      );
    }
    if (state.hasExistingPhoto) {
      return FutureBuilder<File>(
        future: storage.resolveRelativeFile(state.existingPhotoPath!),
        builder: (context, snapshot) {
          final file = snapshot.data;
          if (snapshot.hasError || file == null || !file.existsSync()) {
            return const _PhotoPlaceholder();
          }
          return Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const _PhotoPlaceholder(),
          );
        },
      );
    }
    return null;
  }

  Future<void> _pickAcquisitionDate() async {
    final state = ref.read(vehicleFormControllerProvider);
    final now = DateTime.now();
    final initial =
        DateTime.tryParse(state.acquisitionDate)?.toLocal() ?? now;
    if (!mounted) return;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null && mounted) {
      final value =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      ref.read(vehicleFormControllerProvider.notifier).setAcquisitionDate(value);
      _acquisitionDate.text = value;
    }
  }

  Future<void> _pickPhoto() async {
    try {
      try {
        final picked = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1280,
          maxHeight: 1280,
          imageQuality: 85,
        );
        if (picked != null && mounted) {
          ref
              .read(vehicleFormControllerProvider.notifier)
              .setSelectedImagePath(picked.path);
        }
      } catch (e) {
        // M5: traducir el error del picker a un mensaje claro y manejable.
        throw StorageFailure(
          'No se pudo acceder a la cámara. Verifica los permisos de la app.',
          cause: e,
        );
      }
    } on AppFailure catch (e) {
      _showMessage(e.message);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _clearError(String key) {
    if (_localErrors.containsKey(key)) {
      setState(() => _localErrors.remove(key));
    }
  }

  Future<void> _submit(VehicleFormController controller) async {
    final state = ref.read(vehicleFormControllerProvider);

    // Validar campo a campo para mostrar errores en cada controlador.
    final errors = <String, String>{};
    void put(String key, String? error) {
      if (error != null) errors[key] = error;
    }

    put('brand', _validator.validateBrand(state.brand));
    put('model', _validator.validateModel(state.model));
    put('year', _validator.validateYear(state.year));
    put('plate', _validator.validatePlate(state.plate));
    put('odometer', _validator.validateOdometer(state.odometerKm));
    put('fuelType', _validator.validateFuelType(state.fuelType));
    put('tankCapacity', _validator.validateTankCapacity(state.tankCapacity));
    put('acquisitionDate', _validator.validateAcquisitionDate(state.acquisitionDate));
    put('purchaseValue', _validator.validatePurchaseValue(state.purchaseValue));
    put(
      'currentEstimatedValue',
      _validator.validateCurrentEstimatedValue(state.currentEstimatedValue),
    );
    put('color', _validator.validateColor(state.color));
    put('vin', _validator.validateVin(state.vin));
    put('vehicleType', _validator.validateVehicleType(state.vehicleType));
    put('observations', _validator.validateObservations(state.observations));

    if (errors.isNotEmpty) {
      setState(() => _localErrors = errors);
      return;
    }

    final ok = await controller.save();
    if (!ok || !mounted) return;

    ref.invalidate(vehiclesListControllerProvider);
    ref.invalidate(activeVehicleControllerProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.editingMode
              ? 'Vehículo actualizado correctamente.'
              : 'Vehículo creado correctamente.',
        ),
      ),
    );
    context.pop();
  }
}

/// Bloque de foto en miniatura con acciones "Agregar / Cambiar / Quitar".
class _PhotoPickerSection extends StatelessWidget {
  const _PhotoPickerSection({
    required this.hasImage,
    required this.preview,
    required this.loading,
    required this.onPick,
    this.onRemove,
  });

  final bool hasImage;
  final Widget? preview;
  final bool loading;
  final VoidCallback onPick;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPick,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withAlpha(15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: hasImage && preview != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: preview,
                  )
                : const _PhotoPlaceholder(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              onPressed: loading ? null : onPick,
              icon: const Icon(Icons.photo_library_outlined, size: 18),
              label: Text(hasImage ? 'Cambiar foto' : 'Agregar foto'),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 4),
              TextButton.icon(
                onPressed: loading ? null : onRemove,
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Quitar'),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.add_a_photo_outlined, size: 36, color: AppColors.primaryBlue),
        SizedBox(height: 8),
        Text(
          'Foto del vehículo',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _FuelTypeSelector extends StatelessWidget {
  const _FuelTypeSelector({
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de combustible *',
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final fuel in VehicleProfile.fuelTypes)
              ChoiceChip(
                label: Text(_fuelLabel(fuel)),
                selected: value == fuel,
                onSelected: (_) => onChanged(fuel),
              ),
          ],
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }

  static String _fuelLabel(String fuel) => switch (fuel) {
        'gasolina' => 'Gasolina',
        'diesel' => 'Diésel',
        'electrico' => 'Eléctrico',
        'hibrido' => 'Híbrido',
        _ => fuel,
      };
}

/// Controladores de texto de la sección "Datos adicionales".
class _AdditionalDataControllers {
  const _AdditionalDataControllers({
    required this.tankCapacity,
    required this.acquisitionDate,
    required this.purchaseValue,
    required this.currentEstimatedValue,
    required this.color,
    required this.vin,
    required this.observations,
  });

  final TextEditingController tankCapacity;
  final TextEditingController acquisitionDate;
  final TextEditingController purchaseValue;
  final TextEditingController currentEstimatedValue;
  final TextEditingController color;
  final TextEditingController vin;
  final TextEditingController observations;
}

/// Sección colapsable con los datos opcionales del vehículo (punto 10):
/// capacidad del tanque, fecha de adquisición, valores, color, VIN, tipo de
/// vehículo y observaciones. Se mantiene contraída por defecto para no
/// saturar el formulario principal.
class _AdditionalDataSection extends StatelessWidget {
  const _AdditionalDataSection({
    required this.controllers,
    required this.vehicleType,
    required this.errors,
    required this.onChanged,
    required this.onPickDate,
    required this.onClearDate,
  });

  final _AdditionalDataControllers controllers;
  final String vehicleType;
  final Map<String, String> errors;

  /// Recibe el campo ('tankCapacity', 'color', ...) y el nuevo valor.
  final void Function(String field, String value) onChanged;
  final VoidCallback onPickDate;
  final VoidCallback onClearDate;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      shape: const Border(),
      collapsedShape: const Border(),
      title: const Text(
        'Datos adicionales (opcionales)',
        style: TextStyle(fontSize: 15, color: AppColors.textPrimary),
      ),
      childrenPadding: const EdgeInsets.only(top: 8, bottom: 4),
      children: [
        AppTextField(
          label: 'Capacidad del tanque (L)',
          hint: 'Ej. 45.5',
          controller: controllers.tankCapacity,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          errorText: errors['tankCapacity'],
          onChanged: (v) => onChanged('tankCapacity', v),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controllers.acquisitionDate,
          readOnly: true,
          onTap: onPickDate,
          decoration: InputDecoration(
            labelText: 'Fecha de adquisición',
            hintText: 'Ej. 2023-05-01',
            errorText: errors['acquisitionDate'],
            suffixIcon: controllers.acquisitionDate.text.isEmpty
                ? const Icon(Icons.calendar_today_outlined, size: 20)
                : IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: onClearDate,
                    tooltip: 'Quitar fecha',
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Valor de compra (COP)',
                hint: 'Ej. 45000000',
                controller: controllers.purchaseValue,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                errorText: errors['purchaseValue'],
                onChanged: (v) => onChanged('purchaseValue', v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppTextField(
                label: 'Valor actual estimado (COP)',
                hint: 'Ej. 42000000',
                controller: controllers.currentEstimatedValue,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                errorText: errors['currentEstimatedValue'],
                onChanged: (v) => onChanged('currentEstimatedValue', v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Color',
                hint: 'Ej. Rojo oscuro',
                controller: controllers.color,
                textInputAction: TextInputAction.next,
                errorText: errors['color'],
                onChanged: (v) => onChanged('color', v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppTextField(
                label: 'VIN',
                hint: 'Ej. 8AJB276A0C1234567',
                controller: controllers.vin,
                textInputAction: TextInputAction.next,
                errorText: errors['vin'],
                onChanged: (v) => onChanged('vin', v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _VehicleTypeSelector(
          value: vehicleType,
          errorText: errors['vehicleType'],
          onChanged: (v) => onChanged('vehicleType', v),
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: 'Observaciones',
          hint: 'Notas libres sobre el vehículo',
          controller: controllers.observations,
          maxLines: 3,
          maxLength: 500,
          errorText: errors['observations'],
          onChanged: (v) => onChanged('observations', v),
        ),
      ],
    );
  }
}

class _VehicleTypeSelector extends StatelessWidget {
  const _VehicleTypeSelector({
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de vehículo',
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in VehicleProfile.vehicleTypes)
              ChoiceChip(
                label: Text(_typeLabel(type)),
                selected: value == type,
                onSelected: (_) => onChanged(type),
              ),
          ],
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }

  static String _typeLabel(String type) => switch (type) {
        'carro' => 'Carro',
        'moto' => 'Moto',
        'camioneta' => 'Camioneta',
        'otro' => 'Otro',
        _ => type,
      };
}