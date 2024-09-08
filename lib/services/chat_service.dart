import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nutriapp/variables.dart';

class ChatService {
  // Obtener chats del paciente
  Future<List<dynamic>> getChatsByPatientId(int patientId) async {
    final url = '${Environment.baseUrl}/chats/$patientId';
    print("Fetching chats from: $url");

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/hal+json',
        },
      );

      if (response.statusCode == 200) {
        print("Chats fetched successfully.");
        return jsonDecode(response.body);
      } else {
        print('Error al obtener los chats: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception occurred while fetching chats: $e');
      return [];
    }
  }

  // Crear un nuevo chat
  Future<int?> createChat(String chatName) async {
    final url = '${Environment.baseUrl}/createChat';
    print("Creating chat with name: $chatName");

    try {
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
        print("Chat created successfully with ID: ${data['id']}");
        return data['id']; // Devuelve el ID del chat
      } else {
        print('Error al crear el chat: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception occurred while creating chat: $e');
      return null;
    }
  }

  // Crear una nueva conversación
  Future<void> createConversation(String text, int chatId, bool isBot) async {
    final url = '${Environment.baseUrl}/createConversation';
    print("Creating conversation in chat ID $chatId with text: $text");

    try {
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

      if (response.statusCode == 200) {
        print("Conversation created successfully.");
      } else {
        print('Error al crear la conversación: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while creating conversation: $e');
    }
  }
}
