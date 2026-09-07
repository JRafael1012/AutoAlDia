/// Estado del formulario de creación de perfil (local a la pantalla).
class ProfileSetupState {
  const ProfileSetupState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.pinEnabled = false,
    this.pin = '',
    this.pinConfirm = '',
    this.biometricsEnabled = false,
    this.submitting = false,
    this.errorMessage,
    this.completed = false,
  });

  final String name;
  final String email;
  final String phone;

  /// El usuario decidió definir un PIN en la configuración inicial.
  final bool pinEnabled;
  final String pin;
  final String pinConfirm;

  /// Solo se ofrece si el usuario definió PIN (la biometría desbloquea el PIN).
  final bool biometricsEnabled;

  final bool submitting;
  final String? errorMessage;
  final bool completed;

  ProfileSetupState copyWith({
    String? name,
    String? email,
    String? phone,
    bool? pinEnabled,
    String? pin,
    String? pinConfirm,
    bool? biometricsEnabled,
    bool? submitting,
    String? errorMessage,
    bool? completed,
  }) {
    return ProfileSetupState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      pin: pin ?? this.pin,
      pinConfirm: pinConfirm ?? this.pinConfirm,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      submitting: submitting ?? this.submitting,
      errorMessage: errorMessage ?? this.errorMessage,
      completed: completed ?? this.completed,
    );
  }
}