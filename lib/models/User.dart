class User {
  final int id;
  final String username;
  final String password;
  final String role;
  final bool active;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.active,
  });

  // Método para convertir de JSON a User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      active: json['active'],
    );
  }

  // Método para convertir de User a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'active': active,
    };
  }
}
