import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutriapp/services/chat_service.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/nutritionist/informaton_patient/chatsSavedHistorialPatient.dart';
import 'package:nutriapp/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/Patient.dart';
import '../chat/conversation.dart';

class ChatSavedPatientPage extends StatefulWidget {
  const ChatSavedPatientPage({Key? key}) : super(key: key);

  @override
  State<ChatSavedPatientPage> createState() => _ChatSavedPatientPageState();
}

class _ChatSavedPatientPageState extends State<ChatSavedPatientPage> {
  late Future<List<dynamic>> _chatsFuture;
  final ChatService _chatService = ChatService();
  Patient patient = new Patient(
      id: 0,
      name: "",
      lastName: "",
      email: "",
      phone: "",
      address: "",
      birthday: "",
      dni: "",
      code: "",
      height: 0,
      weight: 0,
      imageUrl: "",
      preferences: [],
      allergies: [],
      objective: "");

  @override
  void initState() {
    _chatsFuture = getChatsByPatientId();
    super.initState();
    // print(patientId);
    // _chatsFuture = _chatService.getChatsByPatientId(patientId);
  }

  Future<List> getChatsByPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientTmp = prefs.getString('patient')!;
    setState(() {
      patient = Patient.fromJson(jsonDecode(patientTmp));
    });
    return _chatService.getChatsByPatientId(patient.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildPatientInfo(),
/*            const SizedBox(height: 20),
            _buildSectionTitle("Iniciar nueva conversación"),
            const SizedBox(height: 20),
            _buildNewConversationButton(),*/
            const SizedBox(height: 20),
            _buildSectionTitle("Conversaciones guardadas"),
            const SizedBox(height: 20),
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
                  List<dynamic> chats = snapshot.data!;
                  chats.sort((a, b) => b['id']
                      .compareTo(a['id'])); // Orden descendente por chatId
                  return Column(
                    children:
                        chats.map((chat) => _buildChatItem(chat)).toList(),
                  );
                }
              },
            ),
          ],
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
        border: Border.all(color: verdeMain, width: 2.0),
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
                _buildText("Nombre: " + patient.name, Colors.black, 18),
                const SizedBox(height: 8),
                _buildText('Edad: ${patient.birthday} años', Colors.black, 18),
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

  Widget _buildSectionTitle(String title) {
    return _buildText(title, verdeMain, 35, FontWeight.w600);
  }

  Widget _buildNewConversationButton() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConversationPage()),
            );
          },
          icon: Image.asset(
            'assets/ChatGPT_Logo.png',
            width: 24,
            height: 24,
          ),
          label: const Text(
            "Nueva conversación",
            style: TextStyle(fontSize: 18, color: Colors.green), // Texto verde
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            side: BorderSide(color: verdeMain, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(dynamic chat) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatSavedHistorialPatientPage(chatId: chat['id']),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.green, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/avatar.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                // Asegúrate de decodificar correctamente el nombre del chat
                child: _buildText(utf8.decode(chat['chatName'].runes.toList()),
                    Colors.black, 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text, Color color, double fontSize,
      [FontWeight fontWeight = FontWeight.normal]) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
