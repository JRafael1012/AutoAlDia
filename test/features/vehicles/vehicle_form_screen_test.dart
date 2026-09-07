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
}