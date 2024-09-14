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

  Future<void> _sendMessage(String message) async {
    if (message.isEmpty || hasError) return;

    setState(() {
      _visibleMessages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });

    if (!chatCreated) {
      chatCreated = await _createNewChat();
    }

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

  String formatRecipeTitles(String response) {
    // Define los patrones para todas las variaciones posibles de los títulos
    final Map<String, RegExp> titlePatterns = {
      'Título: ': RegExp(r'\b[Tt][íi]?tulo\s*:\s*', caseSensitive: false),
      'Tiempo de preparación: ': RegExp(r'\b[Tt]iempo\s+de\s+preparaci[oó]n\s*:\s*', caseSensitive: false),
      'Nivel de dificultad: ': RegExp(r'\b[Nn]ivel\s+de\s+dificultad\s*:\s*', caseSensitive: false),
      'Ingredientes: ': RegExp(r'\b[Ii]ngredientes\s*:\s*', caseSensitive: false),
      'Utensilios: ': RegExp(r'\b[Uu]tensilios\s*:\s*', caseSensitive: false),
      'Pasos de preparación: ': RegExp(r'\b[Pp]asos\s+de\s+preparaci[oó]n\s*:\s*', caseSensitive: false),
      'Valores nutricionales: ': RegExp(r'\b[Vv]alores\s+nutricionales\s*:\s*', caseSensitive: false),
    };

    // Reemplaza todas las variaciones por el formato correcto
    String formattedResponse = response;
    titlePatterns.forEach((correctTitle, pattern) {
      formattedResponse = formattedResponse.replaceAll(pattern, correctTitle);
    });

    return formattedResponse;
  }

  Future<String?> _fetchOpenAIResponse(String message) async {
    final apiUrl = Environment.openAIUrl;

    String initialPrompt = """
  Eres un asistente de nutrición muy avanzado que se preocupa profundamente por el bienestar físico y mental del usuario. 
  Siempre brindas recomendaciones detalladas y personalizadas basadas en hábitos saludables, equilibrio nutricional y estilo de vida. 
  Tus respuestas son claras y directas, pero a la vez completas, asegurando que el usuario reciba toda la información necesaria para hacer elecciones alimenticias responsables y sostenibles. 
  Tus recomendaciones están basadas en la ciencia más actualizada y consideras factores como alergias, preferencias alimentarias, necesidades nutricionales específicas y objetivos de salud. 
  Siempre motivas al usuario a mejorar su bienestar físico y emocional a largo plazo, recordándoles la importancia de mantenerse activos y de llevar una vida equilibrada tanto en lo físico como en lo mental.

  Si el usuario solicita una receta alimenticia, devuélvela en el siguiente formato:

  - Título: [Título de la receta]
  - Tiempo de preparación: [Tiempo estimado]
  - Nivel de dificultad: [Del 1 al 5]
  - Ingredientes: [Lista de ingredientes con cantidades específicas]
  - Utensilios: [Utensilios necesarios]
  - Pasos de preparación: [Lista de pasos]
  - Valores nutricionales: [Calorías, grasas, proteínas, carbohidratos, etc.]
  """;

    List<Map<String, String?>> conversationHistory = _visibleMessages.map((msg) {
      return {
        'role': msg['role'] as String?,
        'content': msg['content'] as String?,
      };
    }).toList();

    conversationHistory.insert(0, {
      'role': 'system',
      'content': initialPrompt,
    });

    conversationHistory.add({
      'role': 'user',
      'content': message,
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Environment.openAIKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-4',
          'messages': conversationHistory,
          'max_tokens': 1500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        String aiResponse = data['choices'][0]['message']['content'].trim();

        // Llama a la función para formatear todos los títulos
        aiResponse = formatRecipeTitles(aiResponse);

        return aiResponse;
      } else {
        return 'Error al conectar con OpenAI.';
      }
    } catch (e) {
      return 'Error al conectarse con OpenAI: $e';
    }
  }

  Future<void> _analyzeImageWithVisionService(File image) async {
    final apiUrl = '${Environment.urlVision}analyze-image';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    setState(() {
      _visibleMessages.add({'role': 'user', 'content': '[Imagen cargada]'});
      _isLoading = true;
    });

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

        await _chatService.createConversation("[Imagen cargada]", chatId!, false);
        await _chatService.createConversation(visionResponse, chatId!, true);

      } else {
        _handleError('Error al analizar la imagen.');
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

  void _showNotification(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
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
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75, // Máximo 75% del ancho de la pantalla
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
            padding: const EdgeInsets.all(16.0),
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
                      _scrollToBottom();
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
