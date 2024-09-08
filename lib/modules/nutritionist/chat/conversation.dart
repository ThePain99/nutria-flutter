import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutriapp/services/chat_service.dart';
import 'package:nutriapp/variables.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _visibleMessages = [];
  bool _isLoading = false;
  int? chatId;
  int chatCounter = 1;

  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    _initializeChat(); // Inicia el chat de manera secuencial.
  }

  Future<void> _initializeChat() async {
    setState(() {
      _isLoading = true;
    });
    final chatName = 'Conversación $chatCounter';
    chatCounter++;
    chatId = await _chatService.createChat(chatName, Environment.patientId);

    if (chatId != null) {
      debugPrint('Nuevo chat creado con ID: $chatId');
    } else {
      debugPrint('Error creando nuevo chat');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _sendMessage(String message) async {
    if (chatId == null) return;

    setState(() {
      _visibleMessages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });

    await _chatService.createConversation(message, chatId!, false);
    _messageController.clear();

    final response = await _fetchOpenAIResponse(message);

    if (response != null) {
      setState(() {
        _visibleMessages.add({'role': 'assistant', 'content': response});
        _isLoading = false;
      });

      await _chatService.createConversation(response, chatId!, true);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _fetchOpenAIResponse(String message) async {
    final apiUrl = Environment.openAIUrl;
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Environment.openAIKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': 'Eres un asistente de nutrición.'},
            {'role': 'user', 'content': message}
          ],
          'max_tokens': 1024, // Mayor cantidad de tokens
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].trim();
      } else {
        return 'Error al conectar con OpenAI.';
      }
    } catch (e) {
      return 'Error al conectarse con OpenAI.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat con Nutricionista AI'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _visibleMessages.length,
              itemBuilder: (context, index) {
                final message = _visibleMessages[index];
                final isUserMessage = message['role'] == 'user';
                return Align(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.green[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message['content']!),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    enabled: !_isLoading,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isLoading
                      ? null
                      : () {
                    if (_messageController.text.isNotEmpty) {
                      _sendMessage(_messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
