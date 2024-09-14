import 'dart:convert';

import 'package:nutriapp/models/Aliments.dart';

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

  Future<List<Patient>> fetchPatientsByNutritionistId(int id) async {
    final url = Uri.parse('${Environment.baseUrl}patient/nutritionist/$id');

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
        List<Patient> patients = jsonResponse.map<Patient>((item) => Patient.fromJson(item)).toList();
        return patients;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el fetchPatientsByNutritionistId: $e');
      return [];
    }
  }

  //fetch aliments by patient id
  Future<List<Aliments>> fetchAlimentsByPatientId(int id) async {
    final url = Uri.parse('${Environment.baseUrl}aliment/patient/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          //content type json utf8
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/hal+json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<Aliments> aliments = jsonResponse.map<Aliments>((item) => Aliments.fromJson(item)).toList();
        return aliments;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el fetchAlimentsByPatientId: $e');
      return [];
    }
  }

  Future<Patient?> updatePatient(Patient patient) async {
    final url = Uri.parse('${Environment.baseUrl}patient/${patient.id}');

    final body = jsonEncode({
      "name": patient.name,
      "lastName": "string",
      "email": patient.email,
      "phone": patient.phone,
      "address": patient.address,
      "birthday": patient.birthday,
      "dni": patient.dni,
      "code": patient.code,
      "height": patient.height,
      "weight": patient.weight,
      "imageUrl": "string",
      "preferences": patient.preferences,
      "allergies": patient.allergies,
      "objective": patient.objective,
    });

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/hal+json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        Patient patient = Patient.fromJson(jsonResponse);
        return patient;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error en el registro: $e');
      return null;
    }
  }
}