import 'package:flutter/material.dart';
import 'dart:io';
import 'package:nutriapp/themes/color.dart';

class InformationFoodPage extends StatelessWidget {
  final File? image;

  const InformationFoodPage({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contenido
              const SizedBox(height: 20),
              _buildGreenText("Información de la comida"),
              const SizedBox(height: 10),
              Center(
                child: image == null
                    ? Text('No image selected.')
                    : Image.file(
                        image!,
                        width: 350, // Ajusta el ancho de la imagen
                        height: 350, // Ajusta el alto de la imagen
                        fit: BoxFit.cover, // Ajusta cómo se escala la imagen
                      ),
              ),
              const SizedBox(height: 20),
              _buildGreenTitle("Proteínas:"),
              _buildBlackSubTitle("- 2 gramos"),
              const SizedBox(height: 10),
              _buildGreenTitle("Carbohidratos:"),
              _buildBlackSubTitle("- 25 gramos"),
              const SizedBox(height: 10),
              _buildGreenTitle("Grasas:"),
              _buildBlackSubTitle("- 0,2 gramos"),
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
      style: const TextStyle(color: Colors.black, fontSize: 19),
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

  Widget _buildGreenTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: verdeMain, fontSize: 28, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildBlackSubTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildNextButton(String textbuttom) {
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
      child: Text(
        textbuttom,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500), // El color del texto dentro del botón
      ),
    );
  }
}
