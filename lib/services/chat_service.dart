import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nutriapp/variables.dart';

class ChatService {
  // Obtener chats del paciente
  Future<List<dynamic>> getChatsByPatientId(int patientId) async {
    final url = '${Environment.baseUrl}?patientId=$patientId';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/hal+json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint('Error al obtener los chats: ${response.statusCode}');
      return [];
    }
  }

  // Crear un nuevo chat
  Future<int?> createChat(String chatName) async {
    final url = '${Environment.baseUrl}/createChat';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'chatName': chatName,
        'patientId': Environment.patientId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id']; // Devuelve el ID del chat
    } else {
      debugPrint('Error al crear el chat: ${response.statusCode}');
      return null;
    }
  }

  // Crear una nueva conversación
  Future<void> createConversation(String text, int chatId, bool isBot) async {
    final url = '${Environment.baseUrl}/createConversation';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'text': text,
        'chatId': chatId,
        'isBot': isBot,
      }),
    );

    if (response.statusCode != 200) {
      debugPrint('Error al crear la conversación: ${response.statusCode}');
    }
  }
}
