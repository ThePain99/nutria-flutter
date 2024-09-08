import 'package:flutter/material.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';
import 'package:nutriapp/modules/user/chats/chatsSavedHistorial.dart';

class ChatSavedPage extends StatefulWidget with NavigationStates {
  const ChatSavedPage({Key? key}) : super(key: key);

  @override
  State<ChatSavedPage> createState() => _ChatSavedPageState();
}

class _ChatSavedPageState extends State<ChatSavedPage> {
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
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: verdeMain,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left:
                          20.0), //adaptar dependiendo a lo que se ve en el menu
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBlackText("Nombre: Dan Mitchel"),
                            SizedBox(height: 8),
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
                ),
              ),
              const SizedBox(height: 20),
              _buildGreenText("Chats Guardados"),
              _buildBlackTitle("Today"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatSavedHistorialPage()),
                    );
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              _buildBlackTitle("Yesterday"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              _buildBlackTitle("Previous 7 days"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "String subtitle", 'assets/ChatGPT_Logo.png'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey, fontSize: 19),
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

  Widget _buildBlackTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),
    );
  }

  Widget _buildBlackSubTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildCardButtom(String subtitle, String image) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.green, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBlackText(subtitle),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
