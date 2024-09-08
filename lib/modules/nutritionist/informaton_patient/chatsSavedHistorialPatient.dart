import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nutriapp/themes/color.dart';

class ChatSavedHistorialPatientPage extends StatefulWidget {
  const ChatSavedHistorialPatientPage({Key? key}) : super(key: key);

  @override
  State<ChatSavedHistorialPatientPage> createState() =>
      _ChatSavedHistorialPatientPageState();
}

class _ChatSavedHistorialPatientPageState
    extends State<ChatSavedHistorialPatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Contenido
              SizedBox(height: 20),
              _buildChat('assets/avatar.jpg',
                  "Cuantas proteínas, carbohidratos y grasa (en gramos) tiene la tortilla de plátano?"),
              _buildChat('assets/ChatGPT_Logo.png',
                  "La cantidad de proteínas, carbohidratos y grasas en una tortilla de plátano puede variar según cómo se prepare y los ingredientes adicionales que se utilicen. Una tortilla de plátano básica, hecha con plátanos maduros, generalmente contiene principalmente carbohidratos y una pequeña cantidad de proteínas y grasas. A continuación, te proporcionaré una estimación aproximada de los valores nutricionales en una tortilla de plátano básica (por cada 100 gramos)"),
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
              width: 50,
              height: 50,
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
      style: const TextStyle(color: Colors.black, fontSize: 17),
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
