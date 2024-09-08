import 'package:bloc/bloc.dart';
import 'package:nutriapp/modules/nutritionist/account/changeAccountsNutricionist.dart';
import 'package:nutriapp/modules/nutritionist/code_patient/codePatient.dart';
import 'package:nutriapp/modules/nutritionist/home/homeNutricionist.dart';
import 'package:nutriapp/modules/nutritionist/politics/politics.dart';
import 'package:nutriapp/modules/nutritionist/profile/profileNutricionist.dart';

enum NavigationEvents {
  //añadir mas vistas

  HomeNutricionistClickedEvent,
  ProfileNutricionistClickedEvent,
  CodePatientClickedEvent,
  PoliticsNutricionistClickedEvent,
  ChangeAccountNutricionistClickedEvent,
  LogoutNutricionistClickedEvent,
}

mixin NavigationNutricionistStates {}

class NavigationBloc
    extends Bloc<NavigationEvents, NavigationNutricionistStates> {
  NavigationBloc()
      : super(HomeNutricionistPage() /* cambiar por la vista de home*/) {
    on<NavigationEvents>((event, emit) {
      switch (event) {
        case NavigationEvents.HomeNutricionistClickedEvent:
          emit(HomeNutricionistPage());
          break;
        case NavigationEvents.ProfileNutricionistClickedEvent:
          emit(ProfileNutricionistPage());
          break;
        case NavigationEvents.CodePatientClickedEvent:
          emit(CodePatientPage());
          break;
        case NavigationEvents.PoliticsNutricionistClickedEvent:
          emit(PoliticsPage());
          break;
        case NavigationEvents.ChangeAccountNutricionistClickedEvent:
          emit(ChangeAccountNutricionistPage());
          break;
        case NavigationEvents.LogoutNutricionistClickedEvent:
          emit(PoliticsPage());
          break;
      }
    });
  }
}