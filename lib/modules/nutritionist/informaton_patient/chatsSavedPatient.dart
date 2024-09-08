import 'package:flutter/material.dart';
import 'package:nutriapp/themes/color.dart';

import '../chat/conversation.dart';

class ChatSavedPatientPage extends StatefulWidget {
  const ChatSavedPatientPage({Key? key}) : super(key: key);

  @override
  State<ChatSavedPatientPage> createState() => _ChatSavedPatientPageState();
}

class _ChatSavedPatientPageState extends State<ChatSavedPatientPage> {
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
            const SizedBox(height: 20),
            _buildSectionTitle("Iniciar nueva conversación"),
            const SizedBox(height: 20),
            _buildNewConversationButton(),
            const SizedBox(height: 20),
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
                _buildText("Nombre: Dan Mitchel", Colors.black, 18),
                const SizedBox(height: 8),
                _buildText("Edad: 29 años", Colors.black, 18),
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



  Widget _buildText(String text, Color color, double fontSize, [FontWeight fontWeight = FontWeight.normal]) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
