import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';

part 'app_database_provider.g.dart';

/// Proveedor único para la instancia de la base de datos.
///
/// Se mantiene viva (keepAlive) porque la BD se abre una vez y se reutiliza
/// durante toda la vida de la app.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => AppDatabase.open();