import 'Aliments.dart';

class Patient {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String birthday;
  final String dni;
  final String code;
  final double height;
  final double weight;
  final String imageUrl;
  final List<String> preferences;
  final List<String> allergies;
  final String objective;
  // final Aliments? nutritionalHistory;

  Patient({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.birthday,
    required this.dni,
    required this.code,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.preferences,
    required this.allergies,
    required this.objective,
    // this.nutritionalHistory,
  });

  // Método para convertir de JSON a Patient
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      birthday: json['birthday'],
      dni: json['dni'],
      code: json['code'],
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      preferences: List<String>.from(json['preferences']),
      allergies: List<String>.from(json['allergies']),
      objective: json['objective'],
      // nutritionalHistory: json['nutritionalHistory'] != null
      //     ? Aliments.fromJson(json['nutritionalHistory'])
      //     : null,
    );
  }

  // Método para convertir de Patient a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'birthday': birthday,
      'dni': dni,
      'code': code,
      'height': height,
      'weight': weight,
      'imageUrl': imageUrl,
      'preferences': preferences,
      'allergies': allergies,
      'objective': objective,
      // 'nutritionalHistory': nutritionalHistory?.toJson(),
    };
  }
}
