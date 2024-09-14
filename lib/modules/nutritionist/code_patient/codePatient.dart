import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriapp/modules/utils/Utils.dart';
import 'package:nutriapp/services/nutritionistServices.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/nutritionist/bloc_navigation_nutricionist/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/Nutritionist.dart';
import '../../../models/Patient.dart';
import '../../../models/User.dart';

class CodePatientPage extends StatefulWidget with NavigationNutricionistStates {
  const CodePatientPage({Key? key}) : super(key: key);

  @override
  State<CodePatientPage> createState() => _CodePatientPageState();
}

class _CodePatientPageState extends State<CodePatientPage> {
  User? user;
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

  Nutritionist nutritionist = new Nutritionist(
      id: 0,
      name: "",
      lastName: "",
      email: "",
      phone: "",
      address: "",
      birthday: "",
      licenceNumber: "",
      specialty: "");

  @override
  void initState() {
    setPatient();
    fetchNutritionist();
    super.initState();
  }

  //fetchPatient
  Future<void> fetchNutritionist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userTemp = prefs.getString('nutritionist')!;
    setState(() {
      nutritionist = Nutritionist
          .fromJson(jsonDecode(userTemp));
    });
  }

  Future<void> setPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientTmp = prefs.getString('patient')!;
    String userTmp = prefs.getString('user')!;
    setState(() {
      patient = Patient.fromJson(jsonDecode(patientTmp));
      user = User.fromJson(jsonDecode(userTmp));
    });
  }

  TextEditingController codePatient = TextEditingController();
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
                            _buildBlackText("Nombre: " + nutritionist.name),
                            SizedBox(height: 8),
                            _buildBlackText("Edad: " + Utils.calculateAge(nutritionist.birthday) + " años"),
                          ],
                        ),
                      ),
                      ClipOval(
                        child: Image.asset(
                          'assets/nutricionista.png',
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
              _buildGreenText("Ingresa el código del paciente"),
              const SizedBox(height: 20),
//Aqui
              _buildTextInput(codePatient),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NutritionistServices().assignNutritionistToPatient(
                            user!.id, codePatient.text);
                      },
                      child: _buildGreenTextCenter("Ingresar"),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.vpn_key, color: verdeMain),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(TextEditingController TextController) {
    return TextField(
      controller: TextController,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
      cursorColor: Colors.green,
      maxLength: 8,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Escribe algo...',
        counterText: '',
        contentPadding: EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.green, width: 2.0),
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
}
