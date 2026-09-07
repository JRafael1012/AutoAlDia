// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repositorio de perfil basado en la base de datos local.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Repositorio de perfil basado en la base de datos local.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Repositorio de perfil basado en la base de datos local.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'62443eb53986a0bd6386e9dda73be83f59b3dea6';

/// Sesión del perfil local (null = aún no hay perfil creado).

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

/// Sesión del perfil local (null = aún no hay perfil creado).
final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, UserProfile?> {
  /// Sesión del perfil local (null = aún no hay perfil creado).
  ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'654f32d603cbbe3dd96b49eb5d063aa7569cef1c';

/// Sesión del perfil local (null = aún no hay perfil creado).

abstract class _$ProfileController extends $AsyncNotifier<UserProfile?> {
  FutureOr<UserProfile?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserProfile?>, UserProfile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile?>, UserProfile?>,
              AsyncValue<UserProfile?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// true si el usuario ya definió un PIN en esta instalación.

@ProviderFor(HasPinController)
final hasPinControllerProvider = HasPinControllerProvider._();

/// true si el usuario ya definió un PIN en esta instalación.
final class HasPinControllerProvider
    extends $AsyncNotifierProvider<HasPinController, bool> {
  /// true si el usuario ya definió un PIN en esta instalación.
  HasPinControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasPinControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasPinControllerHash();

  @$internal
  @override
  HasPinController create() => HasPinController();
}

String _$hasPinControllerHash() => r'54fc31abdf80a38b132faf68cf717a98c944153d';

/// true si el usuario ya definió un PIN en esta instalación.

abstract class _$HasPinController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Estado de desbloqueo de la sesión actual (PIN validado o no).
///
/// Decisión: es estado de sesión en memoria (se reinicia al cerrar la app),
/// no persistido. El PIN validado queda como `unlocked` solo para esta sesión.

@ProviderFor(PinUnlockController)
final pinUnlockControllerProvider = PinUnlockControllerProvider._();

/// Estado de desbloqueo de la sesión actual (PIN validado o no).
///
/// Decisión: es estado de sesión en memoria (se reinicia al cerrar la app),
/// no persistido. El PIN validado queda como `unlocked` solo para esta sesión.
final class PinUnlockControllerProvider
    extends $NotifierProvider<PinUnlockController, bool> {
  /// Estado de desbloqueo de la sesión actual (PIN validado o no).
  ///
  /// Decisión: es estado de sesión en memoria (se reinicia al cerrar la app),
  /// no persistido. El PIN validado queda como `unlocked` solo para esta sesión.
  PinUnlockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinUnlockControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinUnlockControllerHash();

  @$internal
  @override
  PinUnlockController create() => PinUnlockController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$pinUnlockControllerHash() =>
    r'003c6ec35590f1a4c029aee917526b2efebc4458';

/// Estado de desbloqueo de la sesión actual (PIN validado o no).
///
/// Decisión: es estado de sesión en memoria (se reinicia al cerrar la app),
/// no persistido. El PIN validado queda como `unlocked` solo para esta sesión.

abstract class _$PinUnlockController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// true si el usuario habilitó la biometría en la configuración.

@ProviderFor(BiometricsEnabledController)
final biometricsEnabledControllerProvider =
    BiometricsEnabledControllerProvider._();

/// true si el usuario habilitó la biometría en la configuración.
final class BiometricsEnabledControllerProvider
    extends $AsyncNotifierProvider<BiometricsEnabledController, bool> {
  /// true si el usuario habilitó la biometría en la configuración.
  BiometricsEnabledControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricsEnabledControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricsEnabledControllerHash();

  @$internal
  @override
  BiometricsEnabledController create() => BiometricsEnabledController();
}

String _$biometricsEnabledControllerHash() =>
    r'3f9c396518164dd9cad3d0e6a2319a69955ff58a';

/// true si el usuario habilitó la biometría en la configuración.

abstract class _$BiometricsEnabledController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
