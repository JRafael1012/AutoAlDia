/// Perfil local del usuario (entidad pura, sin dependencias de Drift).
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.currency,
    required this.createdAt,
    this.email,
    this.phone,
  });

  final int id;
  final String name;
  final String? email;
  final String? phone;

  /// Moneda activa del usuario. MVP: una sola moneda (default COP).
  final String currency;

  final DateTime createdAt;

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? currency,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      currency: currency ?? this.currency,
      createdAt: createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          currency == other.currency &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, name, email, phone, currency, createdAt);

  @override
  String toString() => 'UserProfile(id: $id, name: $name, currency: $currency)';
}