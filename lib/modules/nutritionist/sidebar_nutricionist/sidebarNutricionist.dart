import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:nutriapp/modules/nutritionist/sidebar_nutricionist/menuItem.dart';
import 'package:nutriapp/modules/nutritionist/bloc_navigation_nutricionist/navigation.dart';

class SideBarNutricionist extends StatefulWidget {
  const SideBarNutricionist({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBarNutricionist>
    with SingleTickerProviderStateMixin<SideBarNutricionist> {
  late final AnimationController _animationController;
  late final StreamController<bool> _isSidebarOpenedStreamController;
  late final Stream<bool> _isSidebarOpenedStream;
  late final StreamSink<bool> _isSidebarOpenedSink;

  static const _animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _isSidebarOpenedStreamController = PublishSubject<bool>();
    _isSidebarOpenedStream = _isSidebarOpenedStreamController.stream;
    _isSidebarOpenedSink = _isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isSidebarOpenedStreamController.close();
    _isSidebarOpenedSink.close();
    super.dispose();
  }

  void _onIconPressed() {
    final isAnimationCompleted = _animationController.status == AnimationStatus.completed;

    if (isAnimationCompleted) {
      _isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      _isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculamos tamaños basados en el tamaño de la pantalla
    double iconSize = screenHeight * 0.03; // Ajuste dinámico del tamaño del ícono
    double fontSize = screenHeight * 0.02; // Ajuste dinámico del tamaño de la fuente

    return StreamBuilder<bool>(
      initialData: false,
      stream: _isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 45,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02), // Margen dinámico
                  color: Colors.green[700],
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.07), // Espaciado dinámico
                      _buildMenuItem(Icons.home, "Sección Principal", iconSize, fontSize, () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.HomeNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.person, "Perfil de Usuario", iconSize, fontSize, () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ProfileNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.person_add, "Añadir Código de Paciente", iconSize, fontSize, () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.CodePatientClickedEvent);
                      }),
                      _buildMenuItem(Icons.policy, "Politicas de Uso", iconSize, fontSize, () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.PoliticsNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.swap_horiz, "Cambiar Usuario", iconSize, fontSize, () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ChangeAccountNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.logout, "Salir", iconSize, fontSize, () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.LogoutNutricionistClickedEvent);
                      }),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: _onIconPressed,
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.green[700],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(IconData icon, String title, double iconSize, double fontSize, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: iconSize, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(0, 8, 10, 16)
      ..quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2)
      ..quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16)
      ..quadraticBezierTo(0, height - 8, 0, height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
