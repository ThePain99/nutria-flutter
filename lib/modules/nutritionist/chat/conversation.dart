import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutriapp/services/chat_service.dart';  // Servicio del chat
import 'package:nutriapp/variables.dart';  // Variables de entorno

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _visibleMessages = [];
  final List<Map<String, String>> _allMessages = [];
  bool _isLoading = false;
  int? chatId;  // ID del chat en uso
  int chatCounter = 1;

  final ChatService _chatService = ChatService();  // Servicio de chat

  @override
  void initState() {
    super.initState();
    _initializeChat(); // Inicia el proceso de chat
  }

  // Inicializa el chat, obteniendo los chats previos del paciente
  Future<void> _initializeChat() async {
    print("Initializing chat...");
    List<dynamic> chats = await _chatService.getChatsByPatientId(Environment.patientId);

    if (chats.isNotEmpty) {
      setState(() {
        chatId = chats.last['id']; // Usa el último chat disponible
        chatCounter = chats.length + 1;
        print("Existing chat found with ID: $chatId");
      });
    } else {
      await _createChat();
    }

    _allMessages.addAll(_buildInitialMessages());
  }

  // Crear un nuevo chat si no existe uno previo
  Future<void> _createChat() async {
    final chatName = 'Conversación $chatCounter';
    chatCounter++;
    chatId = await _chatService.createChat(chatName);

    if (chatId == null) {
      print('Error creating new chat');
    } else {
      print('New chat created with ID: $chatId');
    }
  }

  // Enviar un mensaje
  Future<void> _sendMessage(String message) async {
    setState(() {
      _visibleMessages.add({'role': 'user', 'content': message});
      _allMessages.add({'role': 'user', 'content': message});
      _isLoading = true;
      print('User message: $message');
    });

    // Crear conversación con el mensaje del usuario
    if (chatId != null) {
      await _chatService.createConversation(message, chatId!, false);
    }

    _messageController.clear();
    final response = await _fetchOpenAIResponse(_allMessages);

    if (response != null) {
      setState(() {
        _visibleMessages.add({'role': 'assistant', 'content': response});
        _allMessages.add({'role': 'assistant', 'content': response});
        print('AI response: $response');
        _isLoading = false;
      });

      // Guardar la conversación de la IA
      if (chatId != null) {
        await _chatService.createConversation(response, chatId!, true);
      }
    }
  }

  // Obtener la respuesta de OpenAI
  Future<String?> _fetchOpenAIResponse(List<Map<String, String>> messages) async {
    const apiUrl = Environment.openAIUrl;
    print("Fetching response from OpenAI...");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Environment.openAIKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': messages,
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        print('OpenAI response received: ${data['choices'][0]['message']['content']}');
        return data['choices'][0]['message']['content'].trim();
      } else {
        print('Error fetching OpenAI response: ${response.statusCode}');
        return 'Error al conectar con OpenAI.';
      }
    } catch (e) {
      print('Exception while fetching OpenAI response: $e');
      return 'Error al conectarse con OpenAI.';
    }
  }

  // Mensaje inicial del sistema
  List<Map<String, String>> _buildInitialMessages() {
    return [
      {
        'role': 'system',
        'content': 'Actúa como un nutricionista profesional. Responde de manera precisa y personalizada.'
      }
    ];
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
                final text = message['content']!;
                return Align(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.green[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(text),
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
