import 'dart:convert';

import '../models/Patient.dart';
import '../variables.dart';
import 'package:http/http.dart' as http;

class PatientServices {
  Future<Patient?> fetchPatientById(int id) async {
    final url = Uri.parse('${Environment.baseUrl}patient/$id');

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
        Patient patient = Patient.fromJson(jsonResponse);
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