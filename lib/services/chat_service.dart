import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nutriapp/variables.dart';

class ChatService {
  final String baseUrl = Environment.baseUrl;

  Future<List<dynamic>> getChatsByPatientId(int patientId) async {
    final url = '$baseUrl/chats/$patientId';
    try {
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
    } catch (e) {
      debugPrint('Exception occurred while fetching chats: $e');
      return [];
    }
  }

  Future<int?> createChat(String chatName, int patientId) async {
    final url = '$baseUrl/createChat';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'chatName': chatName,
          'patientId': patientId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      } else {
        debugPrint('Error al crear el chat: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception occurred while creating chat: $e');
      return null;
    }
  }

  Future<void> createConversation(String text, int chatId, bool isBot) async {
    final url = '$baseUrl/createConversation';
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

      if (response.statusCode != 200) {
        debugPrint('Error al crear la conversación: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception occurred while creating conversation: $e');
    }
  }

  Future<List<dynamic>> getConversationsByChatId(int chatId) async {
    // Actualizamos la URL para reflejar la ruta correcta
    final url = '$baseUrl/conversations/$chatId';
    print('Requesting conversations for chatId: $chatId from URL: $url'); // Añade esto para depurar

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/hal+json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Error al obtener las conversaciones: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('Exception occurred while fetching conversations: $e');
      return [];
    }
  }

}
