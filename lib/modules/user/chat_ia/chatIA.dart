import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';

class ChatIAPage extends StatefulWidget with NavigationStates {
  const ChatIAPage({Key? key}) : super(key: key);

  @override
  State<ChatIAPage> createState() => _ChatIAPageState();
}

class _ChatIAPageState extends State<ChatIAPage> {
  TextEditingController messageController = TextEditingController();
  String texto_muestra = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //empieza el chat
                          if (texto_muestra != '')
                            _buildChat('assets/avatar.jpg', texto_muestra)
                          else
                            SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(
                        10), // Define el radio de los bordes redondeados
                    border: Border.all(
                      color: verdeMain, // Define el color del borde
                      width: 2.0, // Define el ancho del borde
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter message",
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            texto_muestra = messageController.text;
                          });
                        },
                        icon: Icon(
                          Icons.send,
                          color: verdeMain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChat(String image, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.green, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey, fontSize: 16),
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
