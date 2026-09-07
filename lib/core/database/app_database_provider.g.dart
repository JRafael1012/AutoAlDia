// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor único para la instancia de la base de datos.
///
/// Se mantiene viva (keepAlive) porque la BD se abre una vez y se reutiliza
/// durante toda la vida de la app.

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Proveedor único para la instancia de la base de datos.
///
/// Se mantiene viva (keepAlive) porque la BD se abre una vez y se reutiliza
/// durante toda la vida de la app.

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Proveedor único para la instancia de la base de datos.
  ///
  /// Se mantiene viva (keepAlive) porque la BD se abre una vez y se reutiliza
  /// durante toda la vida de la app.
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'9c04e9e39700ea07dd5a8a8b651041827783b987';
