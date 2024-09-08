import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriapp/themes/color.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';

class PoliticsPage extends StatefulWidget with NavigationStates {
  const PoliticsPage({Key? key}) : super(key: key);

  @override
  State<PoliticsPage> createState() => _PoliticsPageState();
}

class _PoliticsPageState extends State<PoliticsPage> {
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
              _buildGreenText("Política de uso de datos de usuario"),
              const SizedBox(height: 10),
              _buildBlackTitle("1. Introducción"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Bienvenido a NutrIA, una aplicación móvil diseñada para ayudarte a gestionar tu nutrición y mejorar tu salud. Utilizamos ChatGPT, un motor de inteligencia artificial desarrollado por OpenAI, para ofrecerte recomendaciones personalizadas. Esta política de uso de datos explica cómo recogemos, utilizamos, y protegemos tus datos personales."),
              const SizedBox(height: 5),
              _buildBlackTitle("2. Recopilación de Datos"),
              const SizedBox(height: 5),
              _buildBlackSubTitle("Datos Personales Recopilados"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Para proporcionarte una experiencia personalizada, podemos recopilar los siguientes datos:"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "* Información de perfil: nombre, edad, sexo, altura, peso, y objetivos nutricionales."),
              const SizedBox(height: 5),
              _buildBlackText(
                  "* Datos de salud: historial médico relevante, alergias, y preferencias dietéticas."),
              const SizedBox(height: 5),
              _buildBlackText(
                  "* Datos de uso: interacciones con la aplicación, frecuencia de uso, y consultas realizadas a través de ChatGPT."),
              const SizedBox(height: 5),
              _buildBlackSubTitle("Uso de los Datos"),
              const SizedBox(height: 5),
              _buildBlackText("Tus datos personales serán utilizados para:"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "* Proporcionar recomendaciones nutricionales personalizadas."),
              const SizedBox(height: 5),
              _buildBlackText(
                  "* Mejorar la precisión y relevancia de las respuestas de ChatGPT."),
              const SizedBox(height: 5),
              _buildBlackText(
                  "* Realizar análisis estadísticos para mejorar la calidad de nuestros servicios."),
              const SizedBox(height: 5),
              _buildBlackText(
                  "* Comunicarnos contigo para fines de soporte y notificaciones importantes."),
              const SizedBox(height: 5),
              _buildBlackTitle("3. Compartición de Datos"),
              const SizedBox(height: 5),
              _buildBlackSubTitle("Proveedores de Servicios"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Podemos compartir tus datos con terceros proveedores de servicios que nos ayudan a operar y mejorar nuestra aplicación. Estos proveedores están obligados a proteger tus datos y utilizarlos únicamente para los fines especificados por nosotros."),
              const SizedBox(height: 5),
              _buildBlackSubTitle("Cumplimiento Legal"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Podemos divulgar tus datos personales si así lo requiere la ley o si creemos de buena fe que dicha acción es necesaria para cumplir con una obligación legal, proteger nuestros derechos o propiedad, prevenir fraudes, o proteger la seguridad de nuestros usuarios."),
              const SizedBox(height: 5),
              _buildBlackTitle("4. Seguridad de los Datos"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Implementamos medidas de seguridad razonables para proteger tus datos personales contra acceso, uso o divulgación no autorizados. Sin embargo, ningún sistema de seguridad es infalible y no podemos garantizar la seguridad absoluta de tus datos."),
              const SizedBox(height: 5),
              _buildBlackTitle("5. Tus Derechos"),
              const SizedBox(height: 5),
              _buildBlackSubTitle("Acceso y Corrección"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Tienes el derecho de acceder a los datos personales que tenemos sobre ti y de solicitar la corrección de cualquier información incorrecta o desactualizada."),
              const SizedBox(height: 5),
              _buildBlackSubTitle("Eliminación"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Puedes solicitar la eliminación de tus datos personales en cualquier momento. Sin embargo, esto puede afectar tu capacidad para utilizar ciertos servicios de la aplicación."),
              const SizedBox(height: 5),
              _buildBlackTitle("6. Cambios a esta Política"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Nos reservamos el derecho de actualizar esta política de uso de datos en cualquier momento. Te notificaremos sobre cualquier cambio importante a través de la aplicación o por otros medios de comunicación adecuados."),
              const SizedBox(height: 5),
              _buildBlackTitle("7. Contacto"),
              const SizedBox(height: 5),
              _buildBlackText(
                  "Si tienes alguna pregunta sobre esta política de uso de datos o sobre cómo manejamos tus datos personales, por favor, contacta con los adminitradores de NutrIA."),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              const SizedBox(height: 30),
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
}
