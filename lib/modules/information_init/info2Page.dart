import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nutriapp/themes/color.dart';

class Info2Page extends StatefulWidget {
  const Info2Page({Key? key}) : super(key: key);

  @override
  State<Info2Page> createState() => _Info2PageState();
}

class _Info2PageState extends State<Info2Page> {
  final TextEditingController intoleranciaController = TextEditingController();
  final TextEditingController preferenciasController = TextEditingController();

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
              const Column(
                children: [
                  Text(
                    "Tu cambio esta cerca...",
                    style: TextStyle(
                        color: verdeMain,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildBlackText(
                  "Ingrese sus alergias, intolerancias, afecciones y problemas de salud . . ."),
              _buildAutosizeText(intoleranciaController, 'Escribe aqui <3'),
              const SizedBox(height: 15),
              _buildBlackText(
                  "Ingrese preferencias mas especificas, como frutas favoritas, verduras favoritas, proteinas favoritas como pollo, carne y demas . . ."),
              _buildAutosizeText(preferenciasController, 'Escribe aqui <3'),
              const SizedBox(height: 25),
              _buildBlackText("CONSEJO:"),
              _buildGreyText(
                  "Si omitiste algo, no te preocupes, que podras ingresar esa informacion luego . . ."),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los hijos verticalmente
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/nutria.png'),
                    ),
                    // Puedes agregar más widgets aquí si lo necesitas
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildLoginButton(),
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

  Widget _buildAutosizeText(TextEditingController controller, String text) {
    return TextField(
      controller: controller,
      cursorColor: Colors.green, // Cambia el color del cursor a verde
      style:
          TextStyle(color: Colors.green), // Cambia el color del texto a verde
      minLines: 3,
      maxLines: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          // Aplica el borde verde cuando el TextField está activo (seleccionado)
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const OutlineInputBorder(
          // Aplica el borde verde cuando el TextField está habilitado pero no seleccionado
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: const OutlineInputBorder(
          // Aplica el borde verde cuando el TextField está enfocado
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: text,
        hintStyle: const TextStyle(
            color: Colors.grey), // Cambia el color del hintText a gris
        // Cambia el color del label (si lo estás usando) cuando está flotando
        floatingLabelStyle: const TextStyle(color: Colors.green),
      ),
    );
  }

  Widget _buildGreenText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.green, fontSize: 16),
    );
  }

  Widget _buildButton(String label, IconData icon) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      child: Column(
        children: [
          Icon(icon, size: 48),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildBlackText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 19),
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return Container(
      height: 50, // Establece el ancho del contenedor a 10 píxeles
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: verdeMain, width: 2.0),
          ),
        ),
        style: TextStyle(
          color: verdeMain,
          fontSize: 20,
        ),
        cursorColor: verdeMain,
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        // Aquí debes agregar la lógica para el inicio de sesión
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: verdeMain, backgroundColor: Colors.green,
        shape: const StadiumBorder(),
        elevation: 5,
        shadowColor:
            verdeMain, // Reemplaza con tu variable de color 'verdeMain'
        minimumSize:
            const Size.fromHeight(60), // Texto y otros elementos del botón
      ),
      child: const Text(
        "VAMOS",
        style: TextStyle(
            color: Colors.white), // El color del texto dentro del botón
      ),
    );
  }
}
