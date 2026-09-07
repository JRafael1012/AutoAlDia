// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del formulario de vehículo (crear y editar).
///
/// Mantiene el estado del formulario + validaciones + guardado en un solo
/// lugar testeable, siguiendo el patrón de `ProfileSetupController`.

@ProviderFor(VehicleFormController)
final vehicleFormControllerProvider = VehicleFormControllerProvider._();

/// Controlador del formulario de vehículo (crear y editar).
///
/// Mantiene el estado del formulario + validaciones + guardado en un solo
/// lugar testeable, siguiendo el patrón de `ProfileSetupController`.
final class VehicleFormControllerProvider
    extends $NotifierProvider<VehicleFormController, VehicleFormState> {
  /// Controlador del formulario de vehículo (crear y editar).
  ///
  /// Mantiene el estado del formulario + validaciones + guardado en un solo
  /// lugar testeable, siguiendo el patrón de `ProfileSetupController`.
  VehicleFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleFormControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleFormControllerHash();

  @$internal
  @override
  VehicleFormController create() => VehicleFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleFormState>(value),
    );
  }
}

String _$vehicleFormControllerHash() =>
    r'65176ca2cb8bb0d1fb57528af566184d843e88f5';

/// Controlador del formulario de vehículo (crear y editar).
///
/// Mantiene el estado del formulario + validaciones + guardado en un solo
/// lugar testeable, siguiendo el patrón de `ProfileSetupController`.

abstract class _$VehicleFormController extends $Notifier<VehicleFormState> {
  VehicleFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VehicleFormState, VehicleFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VehicleFormState, VehicleFormState>,
              VehicleFormState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
