// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del repositorio de seguridad (PIN + biometría).
///
/// Dependencias inyectadas de forma directa: no usamos otro provider por ser
/// objetos sin ciclo de vida propios (FlutterSecureStorage y LocalAuthentication
/// son stateless; se instancian de nuevo sin costo real).

@ProviderFor(securityRepository)
final securityRepositoryProvider = SecurityRepositoryProvider._();

/// Proveedor del repositorio de seguridad (PIN + biometría).
///
/// Dependencias inyectadas de forma directa: no usamos otro provider por ser
/// objetos sin ciclo de vida propios (FlutterSecureStorage y LocalAuthentication
/// son stateless; se instancian de nuevo sin costo real).

final class SecurityRepositoryProvider
    extends
        $FunctionalProvider<
          SecurityRepository,
          SecurityRepository,
          SecurityRepository
        >
    with $Provider<SecurityRepository> {
  /// Proveedor del repositorio de seguridad (PIN + biometría).
  ///
  /// Dependencias inyectadas de forma directa: no usamos otro provider por ser
  /// objetos sin ciclo de vida propios (FlutterSecureStorage y LocalAuthentication
  /// son stateless; se instancian de nuevo sin costo real).
  SecurityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securityRepositoryHash();

  @$internal
  @override
  $ProviderElement<SecurityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecurityRepository create(Ref ref) {
    return securityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecurityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecurityRepository>(value),
    );
  }
}

String _$securityRepositoryHash() =>
    r'378d3392ad194cf1fa89d8f3a0f3d6bf2a9ea93a';
