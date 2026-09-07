import 'package:autoaldia/features/vehicles/presentation/screens/vehicle_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void setTallViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);
  }

  testWidgets('muestra errores de validación en los campos obligatorios',
      (tester) async {
    setTallViewport(tester);
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: VehicleFormScreen()),
      ),
    );

    // Pulsar el botón de guardar sin llenar ningún campo.
    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Ingresa la marca del vehículo.'), findsOneWidget);
    expect(find.text('Ingresa el modelo del vehículo.'), findsOneWidget);
    expect(find.text('Ingresa el kilometraje actual.'), findsOneWidget);
    expect(find.text('Selecciona el tipo de combustible.'), findsOneWidget);
  });

  testWidgets('los errores de validación se limpian al corregir el campo',
      (tester) async {
    setTallViewport(tester);
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: VehicleFormScreen()),
      ),
    );

    // Guardar sin llenar: aparecen los errores.
    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Ingresa la marca del vehículo.'), findsOneWidget);

    // Escribir la marca elimina el error correspondiente.
    await tester.enterText(
      find.widgetWithText(TextField, 'Marca *'),
      'Toyota',
    );
    await tester.pump();
    expect(find.text('Ingresa la marca del vehículo.'), findsNothing);
  });

  testWidgets('la sección de datos adicionales es colapsable y muestra sus campos',
      (tester) async {
    setTallViewport(tester);
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: VehicleFormScreen()),
      ),
    );

    // Inicialmente contraída: los campos opcionales no existen en el árbol.
    expect(find.text('Capacidad del tanque (L)'), findsNothing);

    await tester.tap(find.text('Datos adicionales (opcionales)'));
    await tester.pumpAndSettle();

    expect(find.text('Capacidad del tanque (L)'), findsOneWidget);
    expect(find.text('Fecha de adquisición'), findsOneWidget);
    expect(find.text('Valor de compra (COP)'), findsOneWidget);
    expect(find.text('Valor actual estimado (COP)'), findsOneWidget);
    expect(find.text('Color'), findsOneWidget);
    expect(find.text('VIN'), findsOneWidget);
    expect(find.text('Observaciones'), findsOneWidget);
    expect(find.text('Tipo de vehículo'), findsOneWidget);
  });

  testWidgets('valida el VIN en la sección adicional y limpia el error local',
      (tester) async {
    setTallViewport(tester);
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: VehicleFormScreen()),
      ),
    );

    // Llenar los campos obligatorios para aislar el error del VIN.
    await tester.enterText(
      find.widgetWithText(TextField, 'Marca *'),
      'Toyota',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Modelo *'),
      'Corolla',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Kilometraje actual *'),
      '45000',
    );
    await tester.tap(find.text('Gasolina'));
    await tester.pump();

    // Abrir la sección e ingresar un VIN inválido (muy corto).
    await tester.tap(find.text('Datos adicionales (opcionales)'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'VIN'),
      'AB1',
    );
    await tester.pump();

    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(
      find.text('El VIN debe tener al menos 5 caracteres.'),
      findsOneWidget,
    );

    // Corregir el VIN elimina el error local.
    await tester.enterText(
      find.widgetWithText(TextField, 'VIN'),
      '8AJB276A0C1234567',
    );
    await tester.pump();
    expect(
      find.text('El VIN debe tener al menos 5 caracteres.'),
      findsNothing,
    );
  });
}