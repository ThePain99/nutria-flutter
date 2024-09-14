import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriapp/modules/utils/Utils.dart';
import 'package:nutriapp/themes/color.dart';

import 'package:nutriapp/modules/user/profile/profileWithEdit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/Patient.dart';

class ProfilePatientPage extends StatefulWidget {
  const ProfilePatientPage({Key? key}) : super(key: key);

  @override
  State<ProfilePatientPage> createState() => _ProfilePatientPageState();
}

class _ProfilePatientPageState extends State<ProfilePatientPage> {

  Patient patient = new Patient(
      id: 0,
      name: "",
      lastName: "",
      email: "",
      phone: "",
      address: "",
      birthday: "",
      dni: "",
      code: "",
      height: 0,
      weight: 0,
      imageUrl: "",
      preferences: [],
      allergies: [],
      objective: "");

  @override
  void initState() {
    setPatient();
    super.initState();
  }

  Future<void> setPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientTmp = prefs.getString('patient')!;
    setState(() {
      patient = Patient.fromJson(jsonDecode(patientTmp));
    });
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
              const SizedBox(height: 30),
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centra los hijos verticalmente
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          'assets/avatar.jpg',
                          width: 140.0,
                          height: 140.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildBlackSubTitle("Nombre:")),
                    Expanded(flex: 2, child: _buildBlackText(patient.name + " " + patient.lastName)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildBlackSubTitle("Edad:")),
                    Expanded(flex: 2, child: _buildBlackText(Utils.calculateAge(patient.birthday).toString() + " años")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildBlackSubTitle("Estatura:")),
                    Expanded(flex: 2, child: _buildBlackText(patient.height.toString() + " cm")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildBlackSubTitle("Peso:")),
                    Expanded(flex: 2, child: _buildBlackText(patient.weight.toString() + " kg")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2, child: _buildBlackSubTitle("Intensidad:")),
                    Expanded(flex: 2, child: _buildBlackText("Alta")),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildBlackSubTitle("Objetivo:"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: _buildCardButtom(
                      "Ganar Musculo",
                      patient.objective,
                      'assets/ganar_musculo.png'),
                ),
              ),
              const SizedBox(height: 15),
              _buildBlackSubTitle("Afecciones:"),
              for (var allergy in patient.allergies)
                _buildBlackText(allergy),
              const SizedBox(height: 15),
              _buildBlackSubTitle("Comidas favoritas:"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    // Acción cuando se presiona el Card
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.green, width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
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
                                    // for(var aliments in patient.nutritionalHistory!)
                                    //   _buildBlackText(aliments.name),
                                    _buildBlackText("Proteínas"),
                                    _buildBlackText("Bebidas"),
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
              ),
              const SizedBox(height: 15),
              _buildBlackSubTitle("Comidas preferenciales especificas:"),
              _buildBlackText("Fresas, mango, carne de res"),
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
      style: const TextStyle(color: Colors.green, fontSize: 16),
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

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileWithPage()),
        );
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
        "EDITAR CONFIGURACIÓN",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500), // El color del texto dentro del botón
      ),
    );
  }

  Widget _buildCardButtom(String title, String subtitle, String image) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.green, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                      _buildBlackSubTitle(title),
                      SizedBox(height: 8),
                      _buildBlackText(subtitle),
                    ],
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    image,
                    width: 70.0,
                    height: 70.0,
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
