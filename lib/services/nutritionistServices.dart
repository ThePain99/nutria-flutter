import 'dart:convert';

import 'package:nutriapp/models/Nutritionist.dart';
import '../models/Patient.dart';
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

  //edit nutritionist
  Future<Nutritionist?> editNutritionist(Nutritionist nutritionist) async {
    final url = Uri.parse('${Environment.baseUrl}nutritionist/${nutritionist.id}');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/hal+json',
        },
        body: jsonEncode(nutritionist.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        Nutritionist nutritionist = Nutritionist.fromJson(jsonResponse);
        return nutritionist;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el fetchPatientById: $e');
      return null;
    }
  }

  //assign nutritionist to patient
  Future<String?> assignNutritionistToPatient(int nutritionistId, String patientDni) async {
    final url = Uri.parse('${Environment.baseUrl}patient/$patientDni/nutritionist/$nutritionistId');
    print('nutritionistId: $nutritionistId'+ 'patientDni: $patientDni');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/hal+json',
        },
      );

      if (response.statusCode == 200) {
        return 'Nutritionist assigned to patient';
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el fetchPatientById: $e');
      return null;
    }
  }
}