import 'package:bloc/bloc.dart';
import 'package:nutriapp/modules/user/accounts/changeAccounts.dart';
import 'package:nutriapp/modules/user/camera/activateCamera.dart';
import 'package:nutriapp/modules/user/chat_ia/chatIA.dart';
import 'package:nutriapp/modules/user/chats/chatsSaved.dart';
import 'package:nutriapp/modules/user/code_friend/codefriend.dart';
import 'package:nutriapp/modules/user/food_favorite/favorite.dart';
import 'package:nutriapp/modules/user/graphipcs/graphics.dart';
import 'package:nutriapp/modules/user/home/home.dart';
import 'package:nutriapp/modules/user/politics/politics.dart';
import 'package:nutriapp/modules/user/profile/profileWithoutEdit.dart';

enum NavigationEvents {
  HomeClickedEvent,
  ProfileClickedEvent,
  GraphicsClickedEvent,
  FavoriteFoodClickedEvent,
  SavedChatsClickedEvent,
  ChatNutrIAClickedEvent,
  CodeFriendClickedEvent,
  CameraNutrIAClickedEvent,
  UserPolitcsClickedEvent,
  ChangeAccountClickedEvent,
  LogoutClickedEvent,
}

mixin NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(HomePage()) {
    on<NavigationEvents>((event, emit) {
      switch (event) {
        case NavigationEvents.HomeClickedEvent:
          emit(HomePage());
          break;
        case NavigationEvents.ProfileClickedEvent:
          emit(ProfileWithoutPage());
          break;
        case NavigationEvents.GraphicsClickedEvent:
          emit(GraphicsPage());
          break;
        case NavigationEvents.FavoriteFoodClickedEvent:
          emit(FavoritePage());
          break;
        case NavigationEvents.SavedChatsClickedEvent:
          emit(ChatSavedPage());
          break;
        case NavigationEvents.ChatNutrIAClickedEvent:
          emit(ChatIAPage() as NavigationStates);
          break;
        case NavigationEvents.CodeFriendClickedEvent:
          emit(CodeFriendPage());
          break;
        case NavigationEvents.CameraNutrIAClickedEvent:
          emit(ActivateCameraPage());
          break;
        case NavigationEvents.UserPolitcsClickedEvent:
          emit(PoliticsPage());
          break;
        case NavigationEvents.ChangeAccountClickedEvent:
          emit(ChangeAccountPage());
          break;
        case NavigationEvents.LogoutClickedEvent:
          emit(PoliticsPage());
          break;
      }
    });
  }
}
