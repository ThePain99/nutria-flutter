import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriapp/modules/login_and_register/loginPage.dart';
import 'package:nutriapp/themes/color.dart';

class InitApp extends StatefulWidget {
  const InitApp({super.key});

  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                verdeMain,
                verdeOscuro,
                verdeMain,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Healthy',
                      style: TextStyle(
                        fontFamily: GoogleFonts.alfaSlabOne().fontFamily,
                        color: Colors.white,
                        fontSize: 70,
                        fontWeight: FontWeight.normal,
                        shadows: [
                          Shadow(
                            offset: const Offset(2.0, 2.0),
                            blurRadius: 3,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'food for you',
                      style: TextStyle(
                        fontFamily: GoogleFonts.alfaSlabOne().fontFamily,
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.normal,
                        shadows: [
                          Shadow(
                            offset: const Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/nutria_init.png'),
                Column(
                  children: [_buildButton()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: verdeMain, backgroundColor: Colors.green,
        side: const BorderSide(color: Colors.white),
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
          color: Colors.white,
          fontSize: 20,
        ), // El color del texto dentro del botón
      ),
    );
  }
}
