import 'package:flutter/material.dart';
import 'package:nutriapp/themes/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  void _showCamposBlancos(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // El fondo oscuro detrás del diálogo se maneja automáticamente por Flutter
        return AlertDialog(
          title: Text(
            'AVISO',
            style: TextStyle(color: verdeMain, fontWeight: FontWeight.bold),
          ),
          content: Text('Complete todos los campos para continuar.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showCorreoNoCorrespondido(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // El fondo oscuro detrás del diálogo se maneja automáticamente por Flutter
        return AlertDialog(
          title: Text(
            'AVISO',
            style: TextStyle(color: verdeMain, fontWeight: FontWeight.bold),
          ),
          content: Text('El correo ingresado no corresponde a ningún usuario.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showContrasenaIncorrecta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // El fondo oscuro detrás del diálogo se maneja automáticamente por Flutter
        return AlertDialog(
          title: Text(
            'AVISO',
            style: TextStyle(color: verdeMain, fontWeight: FontWeight.bold),
          ),
          content: Text('La contraseña ingresada es incorrecta.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
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
        Text(
          "Log In",
          style: TextStyle(
              color: verdeMain, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 60),
        _buildGreyText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
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
        TextButton(onPressed: () {}, child: _buildGreyText("Sign up here <3")),
        TextButton(
            onPressed: () {}, child: _buildGreyText("I forgot my password"))
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 5,
        shadowColor: verdeMain,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "LOGIN",
        style: TextStyle(color: verdeMain),
      ),
    );
  }
}
