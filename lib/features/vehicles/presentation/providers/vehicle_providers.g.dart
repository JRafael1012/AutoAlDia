// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del repositorio de vehículos basado en Drift.

@ProviderFor(vehicleRepository)
final vehicleRepositoryProvider = VehicleRepositoryProvider._();

/// Proveedor del repositorio de vehículos basado en Drift.

final class VehicleRepositoryProvider
    extends
        $FunctionalProvider<
          VehicleRepository,
          VehicleRepository,
          VehicleRepository
        >
    with $Provider<VehicleRepository> {
  /// Proveedor del repositorio de vehículos basado en Drift.
  VehicleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleRepositoryHash();

  @$internal
  @override
  $ProviderElement<VehicleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VehicleRepository create(Ref ref) {
    return vehicleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleRepository>(value),
    );
  }
}

String _$vehicleRepositoryHash() => r'1fe4f0625d31e025262fb9bbefaee0828c9ea1eb';

/// Lista de vehículos asociados al usuario actual.

@ProviderFor(VehiclesListController)
final vehiclesListControllerProvider = VehiclesListControllerProvider._();

/// Lista de vehículos asociados al usuario actual.
final class VehiclesListControllerProvider
    extends
        $AsyncNotifierProvider<VehiclesListController, List<VehicleProfile>> {
  /// Lista de vehículos asociados al usuario actual.
  VehiclesListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehiclesListControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehiclesListControllerHash();

  @$internal
  @override
  VehiclesListController create() => VehiclesListController();
}

String _$vehiclesListControllerHash() =>
    r'ab6f15d948f4f3c0b2fcae5b4823f1d67b876205';

/// Lista de vehículos asociados al usuario actual.

abstract class _$VehiclesListController
    extends $AsyncNotifier<List<VehicleProfile>> {
  FutureOr<List<VehicleProfile>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<VehicleProfile>>, List<VehicleProfile>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<VehicleProfile>>,
                List<VehicleProfile>
              >,
              AsyncValue<List<VehicleProfile>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Proveedor del vehículo actualmente seleccionado (Vehículo Activo).
///
/// Todas las pantallas que filtran información por vehículo (combustible,
/// mantenimiento, gastos, dashboard) consumen este provider.

@ProviderFor(ActiveVehicleController)
final activeVehicleControllerProvider = ActiveVehicleControllerProvider._();

/// Proveedor del vehículo actualmente seleccionado (Vehículo Activo).
///
/// Todas las pantallas que filtran información por vehículo (combustible,
/// mantenimiento, gastos, dashboard) consumen este provider.
final class ActiveVehicleControllerProvider
    extends $AsyncNotifierProvider<ActiveVehicleController, VehicleProfile?> {
  /// Proveedor del vehículo actualmente seleccionado (Vehículo Activo).
  ///
  /// Todas las pantallas que filtran información por vehículo (combustible,
  /// mantenimiento, gastos, dashboard) consumen este provider.
  ActiveVehicleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeVehicleControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeVehicleControllerHash();

  @$internal
  @override
  ActiveVehicleController create() => ActiveVehicleController();
}

String _$activeVehicleControllerHash() =>
    r'712782bebedf460d0f0aa39ac7aef6719d278605';

/// Proveedor del vehículo actualmente seleccionado (Vehículo Activo).
///
/// Todas las pantallas que filtran información por vehículo (combustible,
/// mantenimiento, gastos, dashboard) consumen este provider.

abstract class _$ActiveVehicleController
    extends $AsyncNotifier<VehicleProfile?> {
  FutureOr<VehicleProfile?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<VehicleProfile?>, VehicleProfile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VehicleProfile?>, VehicleProfile?>,
              AsyncValue<VehicleProfile?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
