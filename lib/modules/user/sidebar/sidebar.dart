import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
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
    final isAnimationCompleted =
        _animationController.status == AnimationStatus.completed;
    isSidebarOpenedSink.add(!isAnimationCompleted);
    isAnimationCompleted
        ? _animationController.reverse()
        : _animationController.forward();
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      _buildMenuItems(context),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: onIconPressed,
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuItem(
          icon: Icons.home,
          title: "Sección Principal",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.HomeClickedEvent);
          },
        ),
        const SizedBox(height: 10),
        MenuItem(
          icon: Icons.person,
          title: "Perfil de Usuario",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.ProfileClickedEvent);
          },
        ),
        // const SizedBox(height: 10),
        // MenuItem(
        //   icon: Icons.car_crash,
        //   title: "Gráficos",
        //   onTap: () {
        //     onIconPressed();
        //     BlocProvider.of<NavigationBloc>(context)
        //         .add(NavigationEvents.GraphicsClickedEvent);
        //   },
        // ),
        const SizedBox(height: 10),
        MenuItem(
          icon: Icons.favorite,
          title: "Favoritos",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.FavoriteFoodClickedEvent);
          },
        ),
        const SizedBox(height: 10),
        MenuItem(
          icon: Icons.chat_bubble_outline,
          title: "Iniciar nueva conversación",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ChatNutrIAClickedEvent);
          },
        ),
        const SizedBox(height: 10),
        MenuItem(
          icon: Icons.history,
          title: "Ver historial de conversaciones",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.SavedChatsClickedEvent);
          },
        ),
        const SizedBox(height: 10),
        MenuItem(
          icon: Icons.policy,
          title: "Política de Uso",
          onTap: () {
            onIconPressed();
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationEvents.UserPolitcsClickedEvent);
          },
        ),
        const SizedBox(height: 10),
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
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(size.width - 1, size.height / 2 - 20, size.width,
        size.height / 2);
    path.quadraticBezierTo(size.width + 1, size.height / 2 + 20, 10,
        size.height - 16);
    path.quadraticBezierTo(0, size.height - 8, 0, size.height);
    return path..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
