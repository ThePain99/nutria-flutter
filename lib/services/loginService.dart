import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nutriapp/models/User.dart';
import 'package:nutriapp/variables.dart';

class LoginService {
  Future<User?> login(String email, String password) async {
    final url = Uri.parse('${Environment.baseUrl}user/login');

    final body = jsonEncode({
      'username': email,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/hal+json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        User user = User.fromJson(jsonResponse);
        return user;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el login: $e');
      return null;
    }
  }

  Future<User?> register(String fullName, String email, String password, String dni) async {
    final url = Uri.parse('${Environment.baseUrl}patient/create');

    final body = jsonEncode({
      "name": fullName,
      "lastName": "string",
      "email": email,
      "phone": "string",
      "address": "string",
      "birthday": "20/11/1999",
      "dni": dni,
      "code": "string",
      "height": 0,
      "weight": 0,
      "imageUrl": "string",
      "user": {
        "username": email,
        "password": password,
        "role": "paciente",
        "active": true
      },
      "preferences": [
        "string"
      ],
      "allergies": [
        "string"
      ],
      "objective": "string"
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/hal+json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        User user = User.fromJson(jsonResponse);
        return user;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el registro: $e');
      return null;
    }
  }
}
