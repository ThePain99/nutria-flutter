import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriapp/themes/color.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final TextEditingController kiloController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  int _selectedIndex = -1;
  bool rememberUser = false;
  bool carbohidratos = false;
  bool proteinas = false;
  bool grasas = false;
  bool verduras = false;
  bool frutas = false;
  bool bebidas = false;

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
                    "Ingrese los siguientes campos",
                    style: TextStyle(
                        color: verdeMain,
                        fontSize: 32,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildGreyText("Peso Actual (Kilogramos)"),
              _buildInputField(kiloController),
              const SizedBox(height: 15),
              _buildGreyText("Estatura Actual (Centimetros)"),
              _buildInputField(alturaController),
              const SizedBox(height: 15),
              _buildGreyText("Intensidad"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.all(
                          5), // Agrega el padding de 10 píxeles entre los botones
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              _selectedIndex == i ? Colors.white : Colors.green,
                          backgroundColor:
                              _selectedIndex == i ? Colors.green : Colors.white,
                          side: const BorderSide(
                              color: Colors.transparent), // Remueve el borde
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: _selectedIndex == i
                              ? 5
                              : 0, // Ajusta la sombra si está seleccionado
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = i;
                          });
                        },
                        child: Text(
                          ['Baja', 'Media', 'Alta'][i],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              _buildGreyText("Comidas favoritas"),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: carbohidratos,
                          onChanged: (value) {
                            setState(() {
                              carbohidratos = value!;
                            });
                          }),
                      const Icon(Icons.cake),
                      const SizedBox(
                        height: 0,
                        width: 10,
                      ),
                      _buildGreenText('Carbohidratos'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: proteinas,
                          onChanged: (value) {
                            setState(() {
                              proteinas = value!;
                            });
                          }),
                      const Icon(Icons.local_dining),
                      const SizedBox(
                        height: 0,
                        width: 10,
                      ),
                      _buildGreenText('Proteinas'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: grasas,
                          onChanged: (value) {
                            setState(() {
                              grasas = value!;
                            });
                          }),
                      const Icon(Icons.fastfood),
                      const SizedBox(
                        height: 0,
                        width: 10,
                      ),
                      _buildGreenText('Grasas'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: verduras,
                          onChanged: (value) {
                            setState(() {
                              verduras = value!;
                            });
                          }),
                      const Icon(Icons.spa),
                      const SizedBox(
                        height: 0,
                        width: 10,
                      ),
                      _buildGreenText('Verduras'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: frutas,
                          onChanged: (value) {
                            setState(() {
                              frutas = value!;
                            });
                          }),
                      const Icon(Icons.apple),
                      const SizedBox(
                        height: 0,
                        width: 10,
                      ),
                      _buildGreenText('Frutas'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: bebidas,
                          onChanged: (value) {
                            setState(() {
                              bebidas = value!;
                            });
                          }),
                      const Icon(Icons.local_drink),
                      const SizedBox(
                        height: 0,
                        width: 10,
                      ),
                      _buildGreenText('Bebidas'),
                    ],
                  ),
                ],
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

  Widget _buildChechBox(String text) {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreenText(text),
          ],
        ),
      ],
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

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 19),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      height: 50, // Establece el ancho del contenedor a 10 píxeles
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
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

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: () {}, child: _buildGreyText("Sign up here <3")),
        TextButton(
            onPressed: () {}, child: _buildGreyText("I forgot my password")),
      ],
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
