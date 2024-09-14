import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriapp/models/Patient.dart';
import 'package:nutriapp/modules/user/home/home.dart';
import 'package:nutriapp/modules/utils/Utils.dart';
import 'package:nutriapp/services/patientServices.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class ProfileWithPage extends StatefulWidget with NavigationStates {
  const ProfileWithPage({Key? key}) : super(key: key);

  @override
  State<ProfileWithPage> createState() => _ProfileWithPageState();
}

class _ProfileWithPageState extends State<ProfileWithPage> {
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

  //initstate
  @override
  void initState() {
    fetchPatient();
    super.initState();
  }

  //fetchPatient
  Future<void> fetchPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userTemp = prefs.getString('user')!;
    setState(() {
      patient = Patient
          .fromJson(jsonDecode(userTemp));
    });
  }

  //controllers dni controller with initial value of 123
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController estaturaController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController intensidadController = TextEditingController();
  final TextEditingController afeccionesController = TextEditingController();
  final TextEditingController comidasController = TextEditingController();
  String intensidad = "Alta";
  bool rememberUser = false;
  bool carbohidratos = false;
  bool proteinas = false;
  bool grasas = false;
  bool verduras = false;
  bool frutas = false;
  bool bebidas = false;
  String objetivo = "Ganar Musculo";

  void _showCardsPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildGreenText("¿Cuál es tu objetivo a lograr?"),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          objetivo = "Ganar Musculo";
                        });
                        Navigator.pop(context);
                      },
                      child: _buildCardButtom(
                          "Ganar Musculo",
                          "Pon tus musculos fuertes y gana fuerza",
                          'assets/ganar_musculo.png')),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          objetivo = "Perder Grasa";
                        });
                        Navigator.pop(context);
                      },
                      child: _buildCardButtom(
                          "Perder Grasa",
                          "Reduce tu indice de grasa, manteniendote en forma",
                          'assets/ganar_musculo.png')),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          objetivo = "Mantener Peso";
                        });
                        Navigator.pop(context);
                      },
                      child: _buildCardButtom(
                          "Mantener Peso",
                          "Manten tu estilo de vida saludable",
                          'assets/ganar_musculo.png')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showOptionsPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildGreenText("Comida favorita"),
                      SizedBox(height: 10),
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
                              _buildGreen2Text('Carbohidratos'),
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
                              _buildGreen2Text('Proteinas'),
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
                              _buildGreen2Text('Grasas'),
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
                              _buildGreen2Text('Verduras'),
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
                              _buildGreen2Text('Frutas'),
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
                              _buildGreen2Text('Bebidas'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildNextButton("APLICAR"),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            });
      },
    );
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
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 30,
                        child: _buildTextField(nombreController),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildBlackSubTitle("Edad:")),
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 30, //aqui se ajusta la altura
                          child: _buildNumber3Field(edadController)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildBlackSubTitle("Estatura:")),
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 30, //aqui se ajusta la altura
                          child: _buildNumber3Field(estaturaController)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildBlackSubTitle("Peso:")),
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 30, //aqui se ajusta la altura
                          child: _buildNumber2Field(pesoController)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2, child: _buildBlackSubTitle("Intensidad:")),
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 40, //aqui se ajusta la altura
                          child: _buildDropDownMenu(intensidad)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildBlackSubTitle("Objetivo:"),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: InkWell(
                  onTap: () {
                    _showCardsPopUp();
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
                                    _buildBlackSubTitle(objetivo),
                                    SizedBox(height: 8),
                                    _buildBlackText(
                                        Utils.setObjetive(objetivo)),
                                  ],
                                ),
                              ),
                              ClipOval(
                                child: Image.asset(
                                  'assets/ganar_musculo.png',
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
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildBlackSubTitle("Afecciones:"),
              _buildAutosizeText(afeccionesController, "Escribe aqui <3"),
              const SizedBox(height: 15),
              _buildBlackSubTitle("Comidas favoritas:"),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: InkWell(
                  onTap: () {
                    _showOptionsPopUp();
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
              _buildAutosizeText(comidasController, "Escribe aqui <3"),
              const SizedBox(height: 30),
              _buildNextButton("APLICAR TODOS LOS CAMBIOS"),
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
      textAlign: TextAlign.center,
    );
  }

  Widget _buildGreen2Text(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: verdeMain, fontSize: 20, fontWeight: FontWeight.w500),
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

  Widget _buildNextButton(String textbuttom) {
    return ElevatedButton(
      onPressed: () {
        PatientServices().updatePatient(
            new Patient(id: patient.id,
                name: nombreController.text,
                lastName: patient.lastName,
                email: patient.email,
                phone: patient.phone,
                address: patient.address,
                birthday: patient.birthday,
                dni: patient.dni,
                code: patient.code,
                height: double.parse(estaturaController.text),
                weight: double.parse(pesoController.text),
                imageUrl: patient.imageUrl,
                preferences: patient.preferences,
                allergies: [afeccionesController.text],
                objective: objetivo));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: verdeMain,
        backgroundColor: Colors.green,
        shape: const StadiumBorder(),
        elevation: 5,
        shadowColor:
        verdeMain,
        // Reemplaza con tu variable de color 'verdeMain'
        minimumSize: const ui.Size.fromHeight(60), // Texto y otros elementos del botón, // Texto y otros elementos del botón
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

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        labelStyle: TextStyle(color: Colors.green),
      ),
    );
  }

  Widget _buildNumber2Field(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2),
      ],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        labelStyle: TextStyle(color: Colors.green),
      ),
    );
  }

  Widget _buildNumber3Field(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        labelStyle: TextStyle(color: Colors.green),
      ),
    );
  }

  Widget _buildDropDownMenu(String valor) {
    return InputDecorator(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: valor,
          onChanged: (String? newValue) {
            setState(() {
              intensidad = newValue!;
            });
          },
          items: <String>['Baja', 'Media', 'Alta']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAutosizeText(TextEditingController controller, String text) {
    return TextField(
      controller: controller,
      cursorColor: Colors.green,
      // Cambia el color del cursor a verde
      style:
      TextStyle(color: Colors.black),
      // Cambia el color del texto a verde
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
            color: Colors.grey),
        // Cambia el color del hintText a gris
        // Cambia el color del label (si lo estás usando) cuando está flotando
        floatingLabelStyle: const TextStyle(color: Colors.green),
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
                SizedBox(width: 10),
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
