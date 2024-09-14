import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutriapp/models/Patient.dart';
import 'package:nutriapp/models/User.dart';
import 'package:nutriapp/modules/nutritionist/sidebar_nutricionist/sidebarNutricionist.dart';
import 'package:nutriapp/modules/nutritionist/sidebar_nutricionist/sidebarNutricionistLayout.dart';
import 'package:nutriapp/modules/user/sidebar/sidebar.dart';
import 'package:nutriapp/modules/user/sidebar/sidebarLayout.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/loginService.dart';

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
  bool isPasswordVisible = false; // Control para mostrar/ocultar contraseña

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: verdeMain),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 0, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
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
            scale: 0.6,
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
          ),
        ),
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
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        )
            : const Icon(Icons.done),
      ),
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: () {}, child: _buildGreyText("Sign up here")),
        TextButton(
            onPressed: () {},
            child: _buildGreyText("I forgot my password"))
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        String email = emailController.text;
        String password = passwordController.text;

        if (email.isEmpty || password.isEmpty) {
          _showErrorDialog(
              context, 'AVISO', 'Complete todos los campos para continuar.');
        } else {
          final loginService = LoginService();
          User? response = await loginService.login(email, password);

          print(response);

          if (response != null) {
            String role = response.role;
            if (role == 'nutricionista') {
              saveUserData(jsonEncode(response));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => SideBarNutricionistlayout()),
              );
            } else if (role == 'paciente') {
              saveUserData(jsonEncode(response));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SideBarlayout()),
              );
            } else {
              _showErrorDialog(context, 'AVISO',
                  'El correo ingresado no corresponde a ningún usuario.');
            }
          } else {
            _showErrorDialog(context, 'AVISO',
                'El correo o la contraseña son incorrectos.');
          }
        }
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

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: verdeMain, fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Aceptar',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveUserData(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
  }
}
