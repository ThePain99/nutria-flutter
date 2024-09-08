import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc_navigation_nutricionist/navigation.dart';
import 'sidebarNutricionist.dart';

class SideBarNutricionistlayout extends StatelessWidget {
  const SideBarNutricionistlayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationNutricionistStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            const SideBarNutricionist(),
          ],
        ),
      ),
    );
  }
}
