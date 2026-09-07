// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_setup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del formulario de creación de perfil.
///
/// Decisión: se usa un `Notifier` local a la pantalla (regla de Riverpod para
/// formularios), no `StateProvider` manuales. Mantiene todo el estado del
/// formulario + la lógica de envío en un solo lugar testeable.

@ProviderFor(ProfileSetupController)
final profileSetupControllerProvider = ProfileSetupControllerProvider._();

/// Controlador del formulario de creación de perfil.
///
/// Decisión: se usa un `Notifier` local a la pantalla (regla de Riverpod para
/// formularios), no `StateProvider` manuales. Mantiene todo el estado del
/// formulario + la lógica de envío en un solo lugar testeable.
final class ProfileSetupControllerProvider
    extends $NotifierProvider<ProfileSetupController, ProfileSetupState> {
  /// Controlador del formulario de creación de perfil.
  ///
  /// Decisión: se usa un `Notifier` local a la pantalla (regla de Riverpod para
  /// formularios), no `StateProvider` manuales. Mantiene todo el estado del
  /// formulario + la lógica de envío en un solo lugar testeable.
  ProfileSetupControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileSetupControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileSetupControllerHash();

  @$internal
  @override
  ProfileSetupController create() => ProfileSetupController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileSetupState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileSetupState>(value),
    );
  }
}

String _$profileSetupControllerHash() =>
    r'595ac58d5deda364d2909391cf1daec437c457a8';

/// Controlador del formulario de creación de perfil.
///
/// Decisión: se usa un `Notifier` local a la pantalla (regla de Riverpod para
/// formularios), no `StateProvider` manuales. Mantiene todo el estado del
/// formulario + la lógica de envío en un solo lugar testeable.

abstract class _$ProfileSetupController extends $Notifier<ProfileSetupState> {
  ProfileSetupState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProfileSetupState, ProfileSetupState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileSetupState, ProfileSetupState>,
              ProfileSetupState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
