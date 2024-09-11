import 'dart:convert'; // Import necesario para utf8
import 'package:flutter/material.dart';
import 'package:nutriapp/services/chat_service.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/user/chats/chatsSavedHistorial.dart';

import '../bloc_navigation/navigation.dart';

class ChatSavedPage extends StatefulWidget with NavigationStates {
  const ChatSavedPage({Key? key}) : super(key: key);

  @override
  State<ChatSavedPage> createState() => _ChatSavedPageState();
}

class _ChatSavedPageState extends State<ChatSavedPage> {
  late Future<List<dynamic>> _chatsFuture;
  final ChatService _chatService = ChatService();
  final int patientId = 1; // Reemplaza este valor con el ID real del paciente

  @override
  void initState() {
    super.initState();
    _chatsFuture = _chatService.getChatsByPatientId(patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildPatientInfo(),
              const SizedBox(height: 20),
              _buildGreenText("Chats Guardados"),
              const SizedBox(height: 10),
              FutureBuilder<List<dynamic>>(
                future: _chatsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error al cargar los chats.'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay conversaciones guardadas.'));
                  } else {
                    // Ordenar los chats por ID descendente
                    List<dynamic> chats = snapshot.data!;
                    chats.sort((a, b) => b['id'].compareTo(a['id']));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: chats.map((chat) {
                        // Decodificación UTF-8 del chatName
                        String chatName = utf8.decode(chat['chatName'].runes.toList());

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatSavedHistorialPage(
                                    chatId: chat['id'],
                                  ),
                                ),
                              );
                            },
                            child: _buildCardButtom(chatName,
                                'assets/ChatGPT_Logo.png'),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: verdeMain,
          width: 2.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBlackText("Nombre: Dan Mitchel"),
                const SizedBox(height: 8),
                _buildBlackText("Edad: 29 años"),
              ],
            ),
          ),
          ClipOval(
            child: Image.asset(
              'assets/avatar.jpg',
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreenText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: verdeMain, fontSize: 35, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildBlackText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 18),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildCardButtom(String subtitle, String image) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.green, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBlackText(subtitle),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ClipOval(
              child: Image.asset(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
