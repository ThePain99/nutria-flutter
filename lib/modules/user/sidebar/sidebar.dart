import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:nutriapp/modules/user/sidebar/menuItem.dart';
import 'package:nutriapp/modules/user/bloc_navigation/navigation.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;

  final _animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.requireData ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.requireData ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.green,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ), //EMPIEZA A PARTIR DE AQUI
                    MenuItem(
                      icon: Icons.home,
                      title: "Sección Principal",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.HomeClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.person,
                      title: "Perfil de Usuario",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ProfileClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.bar_chart,
                      title: "Gráficos",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.GraphicsClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.favorite,
                      title: "Comidas Favoritas",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.FavoriteFoodClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.bookmark,
                      title: "Chats Guardados",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.SavedChatsClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.chat,
                      title: "Chatear con NutrIA",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ChatNutrIAClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.person_add,
                      title: "Añadir Código Amigo",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.CodeFriendClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.camera_alt,
                      title: "Camara NutrIA",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.CameraNutrIAClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.policy,
                      title: "Política de Uso",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.UserPolitcsClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.swap_horiz,
                      title: "Cambiar Cuenta",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.ChangeAccountClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.logout,
                      title: "Salir",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.LogoutClickedEvent);
                      },
                    ),
                  ],
                ),
              )),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.green,
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
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
