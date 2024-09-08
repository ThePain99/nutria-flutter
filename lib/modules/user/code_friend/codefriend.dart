import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';

class CodeFriendPage extends StatefulWidget with NavigationStates {
  const CodeFriendPage({Key? key}) : super(key: key);

  @override
  State<CodeFriendPage> createState() => _CodeFriendPageState();
}

class _CodeFriendPageState extends State<CodeFriendPage> {
  String code = "UD93K)=/";
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
              _buildGreenText("Comparte tu código"),
              const SizedBox(height: 20),
              _buildBlackTitleCenter("Tu código de amigo es:"),
              const SizedBox(height: 5),
              _buildCardOnly(code),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: code));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Código copiado al portapapeles')),
                        );
                      },
                      child: _buildGreenTextCenter("Copiar código"),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.copy, color: verdeMain),
                  ],
                ),
              ),
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

  Widget _buildGreenTextCenter(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: verdeMain, fontSize: 25, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildBlackText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 19),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildBlackTextCode(String text) {
    return Center(
      child: SelectableText(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 30),
      ),
    );
  }

  Widget _buildBlackTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),
    );
  }

  Widget _buildBlackTitleCenter(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildBlackSubTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildCardOnly(String subtitle) {
    return Card(
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
                      _buildBlackTextCode(subtitle),
                    ],
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
