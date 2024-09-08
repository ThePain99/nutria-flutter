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
  int chatCounter = 1; // Esta variable se actualizará correctamente.

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

    // Obtén la cantidad de chats existentes para el paciente
    List<dynamic> existingChats = await _chatService.getChatsByPatientId(Environment.patientId);

    // Determina el número secuencial basado en la cantidad de chats existentes
    chatCounter = existingChats.length + 1;

    final chatName = 'Conversación $chatCounter';
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
            {'role': 'system', 'content': _getEnhancedSystemPrompt()},
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

  String _getEnhancedSystemPrompt() {
    return """
Eres un asistente de nutrición muy avanzado que se preocupa profundamente por el bienestar físico y mental del usuario. Siempre brindas recomendaciones detalladas y personalizadas basadas en hábitos saludables, equilibrio nutricional y estilo de vida. 
Tus respuestas son claras y directas, pero a la vez completas, asegurando que el usuario reciba toda la información necesaria para hacer elecciones alimenticias responsables y sostenibles. 
Tus recomendaciones están basadas en la ciencia más actualizada y consideras factores como alergias, preferencias alimentarias, necesidades nutricionales específicas y objetivos de salud. Siempre motivas al usuario a mejorar su bienestar físico y emocional a largo plazo, recordándoles la importancia de mantenerse activos y de llevar una vida equilibrada tanto en lo físico como en lo mental.
""";
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isUserMessage) ...[
                          // Icono de la IA (OpenAI)
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/ChatGPT_Logo.png'),
                            radius: 15,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isUserMessage ? Colors.green[100] : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message['content']!,
                              style: const TextStyle(fontSize: 16),
                              softWrap: true, // Permite que el texto se ajuste al tamaño de pantalla
                            ),
                          ),
                        ),
                        if (isUserMessage) ...[
                          const SizedBox(width: 8),
                          // Icono del usuario
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/avatar.jpg'),
                            radius: 15,
                          ),
                        ],
                      ],
                    ),
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
