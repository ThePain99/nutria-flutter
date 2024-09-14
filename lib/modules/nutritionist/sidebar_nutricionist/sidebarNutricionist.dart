import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutriapp/modules/login_and_register/loginPage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menuItem.dart';
import '../bloc_navigation_nutricionist/navigation.dart';

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
    isAnimationCompleted ? _animationController.reverse() : _animationController.forward();
    _isSidebarOpenedSink.add(!isAnimationCompleted);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                  color: Colors.green[700],
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                      _buildMenuItem(Icons.home, "Sección Principal", () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.HomeNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.person, "Perfil de Usuario", () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ProfileNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.person_add, "Añadir Código de Paciente", () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.CodePatientClickedEvent);
                      }),
                      _buildMenuItem(Icons.policy, "Politicas de Uso", () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.PoliticsNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.swap_horiz, "Cambiar Usuario", () {
                        _onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ChangeAccountNutricionistClickedEvent);
                      }),
                      _buildMenuItem(Icons.logout, "Salir", () {
                        _onIconPressed();
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.clear();
                        });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
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

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return MenuItem(
      icon: icon,
      title: title,
      onTap: onTap,
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    return Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(0, 8, 10, 16)
      ..quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2)
      ..quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16)
      ..quadraticBezierTo(0, height - 8, 0, height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
