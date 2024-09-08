import 'dart:convert';  // Necesario para la decodificación UTF-8
import 'package:flutter/material.dart';
import 'package:nutriapp/services/chat_service.dart';
import 'package:nutriapp/themes/color.dart';

class ChatSavedHistorialPatientPage extends StatefulWidget {
  final int chatId;

  const ChatSavedHistorialPatientPage({Key? key, required this.chatId}) : super(key: key);

  @override
  State<ChatSavedHistorialPatientPage> createState() => _ChatSavedHistorialPatientPageState();
}

class _ChatSavedHistorialPatientPageState extends State<ChatSavedHistorialPatientPage> {
  late Future<List<dynamic>> _conversationsFuture;
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    _conversationsFuture = _chatService.getConversationsByChatId(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<List<dynamic>>(
          future: _conversationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar la conversación.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay mensajes en esta conversación.'));
            } else {
              List<dynamic> conversations = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: conversations.map((conversation) => _buildConversationItem(conversation)).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildConversationItem(dynamic conversation) {
    bool isBot = conversation['isBot'];

    return Align(
      alignment: isBot ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: isBot ? Colors.white : Colors.green[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.green, width: 2.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícono del usuario o IA
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 15,
                  backgroundImage: AssetImage(isBot
                      ? 'assets/ChatGPT_Logo.png'  // Ícono para el bot
                      : 'assets/avatar.jpg'  // Ícono para el usuario
                  ),
                ),
              ),
              // Texto de la conversación, decodificado en UTF-8
              Expanded(
                child: Text(
                  utf8.decode(conversation['text'].runes.toList()),  // Decodificación UTF-8
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
