class Nutritionist {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String birthday;
  final String licenceNumber;
  final String specialty;

  Nutritionist({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.birthday,
    required this.licenceNumber,
    required this.specialty,
  });

  // Método para convertir de JSON a Nutritionist
  factory Nutritionist.fromJson(Map<String, dynamic> json) {
    return Nutritionist(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      birthday: json['birthday'],
      licenceNumber: json['licenceNumber'],
      specialty: json['specialty'],
    );
  }

  // Método para convertir de Nutritionist a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'birthday': birthday,
      'licenceNumber': licenceNumber,
      'specialty': specialty,
    };
  }
}
