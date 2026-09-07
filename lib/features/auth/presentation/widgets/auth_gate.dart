import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/app_failure.dart';
import '../providers/auth_providers.dart';
import '../screens/pin_lock_screen.dart';
import '../screens/profile_setup_screen.dart';

/// Decide la pantalla inicial según el estado de sesión:
/// 1. Sin perfil → configuración inicial.
/// 2. Perfil con PIN y no desbloqueado → pantalla de bloqueo.
/// 3. Todo correcto → dashboard de la app.
///
/// Este componente será reemplazado por el `redirect` global de GoRouter
/// (core/router/app_router.dart) cuando se integren las demás pantallas.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);

    return profile.when(
      loading: () => const _CenteredMessage(
        message: 'Cargando AutoAlDía…',
        icon: Icons.directions_car,
      ),
      error: (error, _) => _CenteredMessage(
        message: _friendly(error),
        icon: Icons.error_outline,
        actionLabel: 'Reintentar',
        onAction: () => ref.invalidate(profileControllerProvider),
      ),
      data: (user) {
        if (user == null) return const ProfileSetupScreen();

        final hasPin = ref.watch(hasPinControllerProvider);
        return hasPin.when(
          loading: () => const _CenteredMessage(
            message: 'Cargando…',
            icon: Icons.hourglass_empty,
          ),
          error: (error, _) => _CenteredMessage(
            message: _friendly(error),
            icon: Icons.error_outline,
            actionLabel: 'Reintentar',
            onAction: () => ref.invalidate(hasPinControllerProvider),
          ),
          data: (pinSet) {
            final unlocked = ref.watch(pinUnlockControllerProvider);
            if (pinSet && !unlocked) return const PinLockScreen();
            return const _HomePlaceholder();
          },
        );
      },
    );
  }

  static String _friendly(Object error) {
    if (error is AppFailure) return error.message;
    return 'Ocurrió un error inesperado. Intenta de nuevo.';
  }
}

/// Lugar temporal hasta implementar el módulo `dashboard`.
class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AutoAlDía')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Bienvenido. El módulo de vehículos se está preparando.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(message, textAlign: TextAlign.center),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}