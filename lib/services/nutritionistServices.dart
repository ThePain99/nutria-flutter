import 'dart:convert';

import 'package:nutriapp/models/Nutritionist.dart';
import '../variables.dart';
import 'package:http/http.dart' as http;

class NutritionistServices {
  Future<Nutritionist?> fetchNutritionistById(int id) async {
    final url = Uri.parse('${Environment.baseUrl}nutritionist/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/hal+json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        Nutritionist patient = Nutritionist.fromJson(jsonResponse);
        return patient;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el fetchPatientById: $e');
      return null;
    }
  }
}