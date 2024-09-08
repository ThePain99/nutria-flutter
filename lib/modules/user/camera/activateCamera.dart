import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';
import 'dart:io';
import 'informationFood.dart';
import 'package:nutriapp/themes/color.dart';

class ActivateCameraPage extends StatefulWidget with NavigationStates {
  const ActivateCameraPage({Key? key}) : super(key: key);

  @override
  State<ActivateCameraPage> createState() => _ActivateCameraPageState();
}

class _ActivateCameraPageState extends State<ActivateCameraPage> {
  File? _image;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InformationFoodPage(image: _image),
        ),
      );
    }
  }

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
              _buildGreenText("Cámara Analítica"),
              const SizedBox(height: 20),
              _buildNextButton("Abre la cámara para poder analizar la comida"),
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
        _takePicture();
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
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center, // El color del texto dentro del botón
      ),
    );
  }
}
