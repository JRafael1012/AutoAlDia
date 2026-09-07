import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';

/// Pantalla de bloqueo: pide el PIN y ofrece biometría si está habilitada.
class PinLockScreen extends ConsumerStatefulWidget {
  const PinLockScreen({super.key});

  @override
  ConsumerState<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends ConsumerState<PinLockScreen> {
  final _pinController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      // El controlador lanza excepción si el PIN es incorrecto; nunca devuelve false.
      await ref
          .read(pinUnlockControllerProvider.notifier)
          .unlockWithPin(_pinController.text);
    } catch (e) {
      setState(() {
        _error = e is Exception ? e.toString() : 'No se pudo verificar el PIN.';
      });
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<void> _unlockWithBiometrics() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(pinUnlockControllerProvider.notifier)
          .unlockWithBiometrics();
    } catch (e) {
      setState(() {
        _error = e is Exception ? e.toString() : 'No se pudo autenticar.';
      });
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final biometrics = ref.watch(biometricsEnabledControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'AutoAlDía está bloqueado',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _pinController,
                obscureText: true,
                enabled: !_submitting,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                onSubmitted: (_) => _unlock(),
                decoration: InputDecoration(
                  labelText: 'Ingresa tu PIN',
                  border: const OutlineInputBorder(),
                  errorText: _error,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submitting ? null : _unlock,
                icon: const Icon(Icons.check),
                label: const Text('Desbloquear'),
              ),
              biometrics.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (enabled) => enabled
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: OutlinedButton.icon(
                          onPressed: _submitting ? null : _unlockWithBiometrics,
                          icon: const Icon(Icons.fingerprint),
                          label: const Text('Usar huella o rostro'),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}