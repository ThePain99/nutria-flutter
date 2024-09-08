import 'package:flutter/material.dart';
import 'package:nutriapp/themes/color.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: verdeMain,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 0, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.6, // Reducir el tamaño de la imagen al 50%
            child: Image.asset('assets/nutria_init.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recover Account",
          style: TextStyle(
              color: verdeMain, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("What is your email?"),
        const SizedBox(height: 50),
        _buildGreyText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 120),
        _buildLoginButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: () {}, child: _buildGreyText("Log In here <3")),
        TextButton(
            onPressed: () {}, child: _buildGreyText("I forgot my password"))
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 5,
        shadowColor: verdeMain,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "Send Email",
        style: TextStyle(color: verdeMain, fontSize: 20),
      ),
    );
  }
}
