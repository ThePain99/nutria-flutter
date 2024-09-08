import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nutriapp/themes/color.dart';

class FavoriteFoodPatientPage extends StatefulWidget {
  const FavoriteFoodPatientPage({Key? key}) : super(key: key);

  @override
  State<FavoriteFoodPatientPage> createState() =>
      _FavoriteFoodPatientPageState();
}

class _FavoriteFoodPatientPageState extends State<FavoriteFoodPatientPage> {
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
              _buildGreenText("Comidas favoritas"),
              _buildBlackTitle("Desayuno"),
              RecipeTile(),
              RecipeTile(),
              RecipeTile(),
              _buildBlackTitle("Almuerzo"),
              RecipeTile(),
              RecipeTile(),
              RecipeTile(),
              _buildBlackTitle("Cena"),
              RecipeTile(),
              RecipeTile(),
              RecipeTile(),
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
      style: const TextStyle(color: Colors.black, fontSize: 18),
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
}

class RecipeTile extends StatefulWidget {
  //aqui empieza el menu desplegable
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
        backgroundColor: verdeMain, //color cuando esta desplegado
        collapsedBackgroundColor: Colors.amber, //color cuando esta plegado
        title: _buildwhiteSubTitle("Tortilla de Platano"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
            IconButton(
              icon: Icon(
                isSaved ? Icons.star : Icons.star_border,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isSaved = !isSaved;
                });
              },
            ),
          ],
        ),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centra los hijos verticalmente
                          children: <Widget>[
                            ClipOval(
                              child: Image.asset(
                                'assets/avatar.jpg',
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ]),
                    ),
                    _buildBlackSubTitle("Ingredientes"),
                    _buildGreyText("- 2 Huevos"),
                    _buildGreyText("- 1 platano seda"),
                    _buildGreyText("- 1 cuchara de proteina (opcional)"),
                    _buildBlackSubTitle("Preparacion:"),
                    _buildGreyText(
                        "1. Romper los huevos y meterlos en la licuadora."),
                    _buildGreyText(
                        "2. Cortar el platano en trozos y meterlo en la licuadora sin cáscara."),
                    _buildGreyText(
                        "3. Ingresa la cuchara de proteína (opcional)"),
                    _buildBlackSubTitle("Proteínas:"),
                    _buildGreyText("- 2 gramos"),
                    _buildBlackSubTitle("Carbohidratos:"),
                    _buildGreyText("- 25 gramos"),
                    _buildBlackSubTitle("Grasas:"),
                    _buildGreyText("- 0,2 gramos"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.grey, fontSize: 19, fontWeight: FontWeight.w500),
      textAlign: TextAlign.justify,
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

  Widget _buildwhiteSubTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}
