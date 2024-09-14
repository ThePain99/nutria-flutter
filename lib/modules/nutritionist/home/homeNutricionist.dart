import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutriapp/models/Nutritionist.dart';
import 'package:nutriapp/models/User.dart';
import 'package:nutriapp/modules/nutritionist/bloc_navigation_nutricionist/navigation.dart';
import 'package:nutriapp/modules/nutritionist/informaton_patient/chatsSavedPatient.dart';
import 'package:nutriapp/modules/nutritionist/informaton_patient/favoriteFoodPatient.dart';
import 'package:nutriapp/modules/nutritionist/informaton_patient/graphicsPatient.dart';
import 'package:nutriapp/modules/nutritionist/informaton_patient/profilePatient.dart';
import 'package:nutriapp/modules/utils/Utils.dart';
import 'package:nutriapp/services/nutritionistServices.dart';
import 'package:nutriapp/services/patientServices.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/Patient.dart';

class HomeNutricionistPage extends StatefulWidget
    with NavigationNutricionistStates {
  const HomeNutricionistPage({Key? key}) : super(key: key);

  @override
  State<HomeNutricionistPage> createState() => _HomeNutricionistPageState();
}

class _HomeNutricionistPageState extends State<HomeNutricionistPage> {
  User? user;
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
  List<Patient> patients = [];

  @override
  void initState() {
    fetchNutritionist();
    fetchPatients();
    super.initState();
  }

  Future<void> fetchNutritionist() async {
    print("entrando a home2");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userTemp = prefs.getString('user');
    setState(() {
      if (userTemp != null) {
        user = User.fromJson(jsonDecode(userTemp) as Map<String, dynamic>);
      } else {
        print("No nutritionist found in SharedPreferences");
      }
    });
    nutritionist =
        (await NutritionistServices().fetchNutritionistById(user!.id))!;
    prefs.setString("nutritionist", jsonEncode(nutritionist));
  }

  Future<void> fetchPatients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userTemp = prefs.getString('user');
    setState(() {
      if (userTemp != null) {
        user = User.fromJson(jsonDecode(userTemp) as Map<String, dynamic>);
      } else {
        print("No nutritionist found in SharedPreferences");
      }
    });
    print("user" + user!.id.toString());
    List<Patient> fetchPatients =
        await PatientServices().fetchPatientsByNutritionistId(user!.id);
    setState(() {
      patients = fetchPatients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio Nutricionista"),
        backgroundColor: verdeMain,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildPatientInfo(),
              const SizedBox(height: 20),
              _buildGreenText("Lista de usuarios"),
              //build user with patients list
              for (var patient in patients) _buildUser(patient),

              // _buildUser("Dan Mitchel", "UD93K)=/"),
              // _buildUser("Jorge Luna", "UD123)=/"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: verdeMain,
          width: 2.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBlackText("Nombre: " + nutritionist.name),
                const SizedBox(height: 8),
                _buildBlackText(
                    "Edad: ${Utils.calculateAge(nutritionist.birthday)} años"),
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
    );
  }

  Widget _buildUser(Patient patient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              _buildBlackTitle("Nombre: "),
              _buildBlackTitle(patient.name),
            ],
          ),
          Row(
            children: [
              _buildBlackTitle("Código: "),
              _buildBlackTitle(patient.code),
            ],
          ),
          const SizedBox(height: 5),
          _buildCard(patient),
        ],
      ),
    );
  }

  Widget _buildCard(Patient patient) {
    double sizeIcon = 40;
    double sizeText = 15;
    //save patientId in sharedPreferes
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("patient", jsonEncode(patient));
    });
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: Colors.green,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePatientPage()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Datos',
                      style: TextStyle(fontSize: sizeText),
                    ),
                    Icon(Icons.data_usage, color: Colors.green, size: sizeIcon),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GraphicsPatientPage()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Gráficos',
                      style: TextStyle(fontSize: sizeText),
                    ),
                    Icon(Icons.bar_chart, color: Colors.green, size: sizeIcon),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteFoodPatientPage()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Comidas',
                      style: TextStyle(fontSize: sizeText),
                    ),
                    Icon(Icons.fastfood, color: Colors.green, size: sizeIcon),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatSavedPatientPage()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Mensajes',
                      style: TextStyle(fontSize: sizeText),
                    ),
                    Icon(Icons.message, color: Colors.green, size: sizeIcon),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
      style: const TextStyle(color: Colors.black, fontSize: 18),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildBlackTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
    );
  }
}
