import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nutriapp/variables.dart';

class LoginService {
  Future<void> login(String email, String password) async {

    final url = Uri.parse(Environment.localUrl + '/login');

    final body = jsonEncode({
      'username': email,
      'password': password,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print('Login exitoso: ${response.body}');
    } else {
      print('Error en el login: ${response.statusCode}');
    }
  }
}