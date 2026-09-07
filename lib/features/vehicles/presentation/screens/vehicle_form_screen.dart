import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
  }

  @override
  void dispose() {
    _brand.dispose();
    _model.dispose();
    _year.dispose();
    _plate.dispose();
    _odometer.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleFormControllerProvider);
    final controller = ref.read(vehicleFormControllerProvider.notifier);
    _syncControllers(state);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PhotoPickerSection(
            displayPath: state.displayPhotoPath,
            loading: state.submitting,
            onPick: _pickPhoto,
            onRemove: state.existingPhotoPath == null
                ? null
                : () => controller.removePhoto(),
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
            textInputAction: TextInputAction.done,
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

  Future<void> _pickPhoto() async {
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

/// Constante de marcador para "quitar la foto".
class _PhotoPickerSection extends StatelessWidget {
  const _PhotoPickerSection({
    required this.displayPath,
    required this.loading,
    required this.onPick,
    this.onRemove,
  });

  final String? displayPath;
  final bool loading;
  final VoidCallback onPick;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final hasImage = displayPath != null && displayPath!.isNotEmpty;

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
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(displayPath!),
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const _PhotoPlaceholder(),
                    ),
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
                onPressed: onRemove,
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
