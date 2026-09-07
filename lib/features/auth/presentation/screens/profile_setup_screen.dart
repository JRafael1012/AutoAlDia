import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/profile_setup_controller.dart';

/// Pantalla inicial de auto-configuración: crea el perfil local, define el PIN
/// (opcional) y habilita biometría (opcional).
///
/// Diseño: formulario manejado por [ProfileSetupController] (Notifier local a
/// la pantalla, según la regla de Riverpod). Sin paquetes de formularios para
/// no ocultar la lógica detrás de magic.
class ProfileSetupScreen extends ConsumerWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileSetupControllerProvider.notifier);
    final state = ref.watch(profileSetupControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración inicial')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Todo tu vehículo, siempre al día',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                onChanged: controller.setName,
                decoration: const InputDecoration(
                  labelText: 'Tu nombre',
                  hintText: 'Ej. Juan Pérez',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: controller.setEmail,
                decoration: const InputDecoration(
                  labelText: 'Correo (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                onChanged: controller.setPhone,
                decoration: const InputDecoration(
                  labelText: 'Teléfono (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Proteger con PIN'),
                subtitle: const Text('Bloquea la app al abrirla'),
                value: state.pinEnabled,
                onChanged: controller.setPinEnabled,
              ),
              if (state.pinEnabled) ...[
                const SizedBox(height: 12),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: controller.setPin,
                  decoration: const InputDecoration(
                    labelText: 'PIN (4 a 6 dígitos)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: controller.setPinConfirm,
                  decoration: const InputDecoration(
                    labelText: 'Repite el PIN',
                    border: OutlineInputBorder(),
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Desbloquear con huella o rostro'),
                  value: state.biometricsEnabled,
                  onChanged: controller.setBiometricsEnabled,
                ),
              ],
              if (state.errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  state.errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: state.submitting ? null : controller.submit,
                child: state.submitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Empezar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}