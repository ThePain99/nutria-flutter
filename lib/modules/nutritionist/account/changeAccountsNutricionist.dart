import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/nutritionist/bloc_navigation_nutricionist/navigation.dart';

class ChangeAccountNutricionistPage extends StatefulWidget
    with NavigationNutricionistStates {
  const ChangeAccountNutricionistPage({Key? key}) : super(key: key);

  @override
  State<ChangeAccountNutricionistPage> createState() =>
      _ChangeAccountNutricionistPageState();
}

class _ChangeAccountNutricionistPageState
    extends State<ChangeAccountNutricionistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Contenido
              SizedBox(height: 20),
              _buildGreenText("Cuentas"),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                    onTap: () {
                      //añadir accion
                    },
                    child: _buildCardButtom(
                        "Melissa Suarez", 'assets/nutricionista.png', true)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                    onTap: () {
                      //añadir accion
                    },
                    child: _buildCardButtomAddAccount("Añadir Cuenta")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardButtom(String subtitle, String image, bool showicon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7), // Margen inferior de 10
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.green, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      image,
                      width: 75.0,
                      height: 75.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBlackText(subtitle),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Visibility(
                    visible: showicon,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Icon(Icons.check_circle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardButtomAddAccount(String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7), // Margen inferior de 10
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.green, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/añadir_cuenta.png',
                      width: 60.0,
                      height: 60.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBlackText(subtitle),
                      ],
                    ),
                  ),
                ],
              ),
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
}
