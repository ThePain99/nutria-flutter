import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutriapp/models/Patient.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/User.dart';
import '../../../services/patientServices.dart';

class HomePage extends StatefulWidget with NavigationStates {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User? user;
  Patient patient = new Patient(id: 0, name: "", lastName: "", email: "", phone: "", address: ""
      , birthday: "", dni: "", code: "", height: 0, weight: 0, imageUrl: "", preferences: [], allergies: [],
      objective: "");

  @override
  void initState() {
    print("entrando a home");
    fetchPatient();
    super.initState();
  }

  Future<void> fetchPatient() async {
    print("entrando a home2");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userTemp = prefs.getString('user');
    print("patientString");
    print("usertemp"+userTemp!);
    setState(() {
      if (userTemp != null) {
        user = User.fromJson(jsonDecode(userTemp) as Map<String, dynamic>);
      } else {
        print("No patient found in SharedPreferences");
      }
    });

    patient = (await PatientServices().fetchPatientById(user!.id))!;

    print("namepatient"+ patient.name);

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
              const SizedBox(height: 20),
              buildUserProfile(),
              const SizedBox(height: 20),
              buildMenuSection("Menú del día", "Desayuno"),
              buildMenuSection("Menú del día", "Almuerzo"),
              buildMenuSection("Menú del día", "Cena"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserProfile() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: verdeMain, width: 2.0),
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
                buildText("Nombre: " + patient.name + " " + patient.lastName, Colors.black, 18),
                const SizedBox(height: 8),
                buildText("Edad: " + patient.birthday , Colors.black, 18),
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
    );
  }

  Widget buildMenuSection(String sectionTitle, String mealTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildText(sectionTitle, verdeMain, 35, FontWeight.w600),
        buildText(mealTitle, Colors.black, 28, FontWeight.w400),
        const RecipeTile(),
      ],
    );
  }

  Widget buildText(String text, Color color, double fontSize,
      [FontWeight fontWeight = FontWeight.w500]) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}

class RecipeTile extends StatefulWidget {
  const RecipeTile({Key? key}) : super(key: key);

  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  bool isLiked = false;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        collapsedShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: verdeMain,
        collapsedBackgroundColor: Colors.amber,
        title: _buildTileTitle(),
        trailing: _buildTileActions(),
        children: [_buildExpandedContent(context)],
      ),
    );
  }

  Widget _buildTileTitle() {
    return const Text(
      "Tortilla de Platano",
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTileActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(isLiked ? Icons.thumb_up : Icons.thumb_up_outlined, color: Colors.white),
          onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
        ),
        IconButton(
          icon: Icon(isSaved ? Icons.star : Icons.star_border, color: Colors.white),
          onPressed: () {
            setState(() {
              isSaved = !isSaved;
            });
          },
        ),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/avatar.jpg',
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildTextSection("Ingredientes", [
                "- 2 Huevos",
                "- 1 platano seda",
                "- 1 cuchara de proteina (opcional)",
              ]),
              _buildTextSection("Preparación", [
                "1. Romper los huevos y meterlos en la licuadora.",
                "2. Cortar el platano en trozos y meterlo en la licuadora sin cáscara.",
                "3. Ingresa la cuchara de proteína (opcional)"
              ]),
              _buildTextSection("Proteínas", ["- 2 gramos"]),
              _buildTextSection("Carbohidratos", ["- 25 gramos"]),
              _buildTextSection("Grasas", ["- 0,2 gramos"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSection(String title, List<String> texts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        for (var text in texts)
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 19),
          ),
      ],
    );
  }
}
