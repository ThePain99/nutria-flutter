import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  final String openAIKey = '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';

  @override
  void initState() {
    super.initState();
    _allMessages.addAll(_buildInitialMessages());
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _visibleMessages.add({'role': 'user', 'content': message});
      _allMessages.add({'role': 'user', 'content': message});
      _isLoading = true; // Deshabilitar el input mientras la IA responde
    });

    _messageController.clear();
    final response = await _fetchOpenAIResponse(_allMessages);

    if (response != null) {
      setState(() {
        _visibleMessages.add({'role': 'assistant', 'content': response});
        _allMessages.add({'role': 'assistant', 'content': response});
        _isLoading = false; // Rehabilitar el input después de que la IA responda
      });
    }
  }

  Future<String?> _fetchOpenAIResponse(List<Map<String, String>> messages) async {
    const apiUrl = 'https://api.openai.com/v1/chat/completions';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $openAIKey',
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
        return data['choices'][0]['message']['content'].trim();
      } else {
        return 'Error al conectar con OpenAI.';
      }
    } catch (error) {
      return 'Error al conectarse con OpenAI.';
    }
  }

  List<Map<String, String>> _buildInitialMessages() {
    return [
      {
        'role': 'system',
        'content': 'Actúa como un nutricionista profesional. Responde de manera precisa y personalizada basándote en la información proporcionada. Realiza preguntas sobre hábitos alimenticios, estilo de vida, nivel de actividad física y metas de bienestar. Luego, proporciona recomendaciones dietéticas y de ejercicio personalizadas. Mantén el seguimiento de la conversación y ajusta las recomendaciones según la nueva información proporcionada por el usuario.'
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
                    enabled: !_isLoading, // Deshabilitar el input cuando esté cargando
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
