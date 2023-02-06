import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

import '../../ui/screens/chat/chat_conversation/chat_conversation.dart';
import '../../ui/screens/chat/chat_list/chat_list_screen.dart';
import '../../ui/screens/draw_screen/draw_screen.dart';
import '../../ui/screens/home_screen/home_screen.dart';
import '../../ui/screens/login_screen/login_screen.dart';
import '../../ui/screens/sign_up_screen/sign_up_screen.dart';
import '../model_ui/user_ui_model.dart';

class MyRouter {
  static const String home = '/home';
  static const String draw = '/draw';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String chatConversation = '/chatConversation';
  static const String chatList = '/chatList';

  static PageRouteBuilder _buildRouteNavigationWithoutEffect(
      RouteSettings settings, Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      transitionDuration: Duration.zero,
      settings: settings,
    );
  }

  static PageRouteBuilder _buildRouteNavigation(
      RouteSettings settings, Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRouteNavigationWithoutEffect(
          settings,
          HomeScreen(
            arguments: settings.arguments as HomeScreenArguments,
          ),
        );
      case draw:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const DrawScreen(),
        );
      case login:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const LoginScreen(),
        );
      case signUp:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const SignUpScreen(),
        );
      case chatConversation:
        return _buildRouteNavigationWithoutEffect(
          settings,
          ChatConversationScreen(
            friend: settings.arguments as UserModelUI,
          ),
        );
      case chatList:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ChatListScreen(),
        );
      default:
        return _buildRouteNavigationWithoutEffect(
          settings,
          Scaffold(
            body: Center(
              child: Text('No route found: ${settings.name}.'),
            ),
          ),
        );
    }
  }
}
