import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nutriapp/services/chat_service.dart';
import 'package:nutriapp/variables.dart';
import '../bloc_navigation/navigation.dart';

class ChatIAPage extends StatefulWidget implements NavigationStates {
  const ChatIAPage({Key? key}) : super(key: key);

  @override
  State<ChatIAPage> createState() => _ChatIAPageState();
}

class _ChatIAPageState extends State<ChatIAPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _visibleMessages = [];
  bool _isLoading = false;
  int? chatId;
  int chatCounter = 1;
  bool chatCreated = false;
  bool hasError = false;
  File? _selectedImage;

  final ChatService _chatService = ChatService();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void _showNotification(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _sendMessage(String message) async {
    if (message.isEmpty || hasError) return;

    setState(() {
      _visibleMessages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });

    if (!chatCreated) {
      chatCreated = await _createNewChat();
    }

    // Guardar mensaje del usuario en la conversación antes de enviar a OpenAI
    await _chatService.createConversation(message, chatId!, false);

    final response = await _fetchOpenAIResponse(message);

    if (response != null) {
      setState(() {
        _visibleMessages.add({'role': 'assistant', 'content': response});
        _isLoading = false;
      });

      await _chatService.createConversation(response, chatId!, true);
    } else {
      _handleError('Error al obtener respuesta de OpenAI.');
    }
  }

  Future<bool> _createNewChat() async {
    try {
      List<dynamic> existingChats = await _chatService.getChatsByPatientId(Environment.patientId);
      chatCounter = existingChats.length + 1;

      final chatName = 'Conversación $chatCounter';
      chatId = await _chatService.createChat(chatName, Environment.patientId);

      if (chatId != null) {
        return true;
      } else {
        _handleError('Error al crear el chat.');
        return false;
      }
    } catch (e) {
      _handleError('Error al crear el chat: $e');
      return false;
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
          'model': 'gpt-4',
          'messages': [
            {'role': 'system', 'content': _getEnhancedSystemPrompt()},
            {'role': 'user', 'content': message}
          ],
          'max_tokens': 1500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].trim();
      } else {
        return 'Error al conectar con OpenAI.';
      }
    } catch (e) {
      return 'Error al conectarse con OpenAI: $e';
    }
  }

  Future<void> _analyzeImageWithVisionService(File image) async {
    setState(() {
      _visibleMessages.add({'role': 'user', 'content': '[Imagen cargada]'});
      _isLoading = true;
    });

    final apiUrl = '${Environment.urlVision}analyze-image';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        String visionResponse = data['response'];

        setState(() {
          _visibleMessages.add({'role': 'assistant', 'content': visionResponse});
          _isLoading = false;
        });

        // Guardar la conversación relacionada con la imagen
        await _chatService.createConversation("[Imagen cargada]", chatId!, false);
        await _chatService.createConversation(visionResponse, chatId!, true);
      } else {
        _handleError('Error al analizar la imagen con el servicio de visión.');
      }
    } catch (e) {
      _handleError('Error al conectarse con el servicio de visión.');
    }
  }



  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _analyzeImageWithVisionService(_selectedImage!);
    }
  }

  void _handleError(String errorMessage) {
    setState(() {
      hasError = true;
      _isLoading = false;
    });
    _showNotification(errorMessage, Colors.red);
  }

  String _getEnhancedSystemPrompt() {
    return """
Eres un nutricionista profesional que brinda recomendaciones basadas en ciencia actualizada. Tu enfoque está en mejorar la salud del usuario con información detallada, clara y útil.
""";
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat con Nutricionista AI'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
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
                              softWrap: true,
                            ),
                          ),
                        ),
                        if (isUserMessage) ...[
                          const SizedBox(width: 8),
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
                    enabled: !_isLoading && !hasError,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isLoading || hasError
                      ? null
                      : () {
                    if (_messageController.text.isNotEmpty) {
                      _sendMessage(_messageController.text);
                      _messageController.clear();
                      _scrollToBottom(); // Scroll al final al enviar el mensaje
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
