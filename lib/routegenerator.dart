import 'package:flutter/material.dart';
import 'package:tripmap/screens/loginscreen.dart';
import 'package:tripmap/screens/registerscreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final List<dynamic> args =
        settings.arguments as List<dynamic>; //pass argument as userID

    switch (settings.name) {
      //create new homepage for signed in users
      case '/login':
        return CustomPageRoute(child: const LoginScreen());
      case '/register':
        return CustomPageRoute(child: const RegisterScreen());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({
    required this.child,
  }) : super(
          transitionDuration: const Duration(seconds: 0),
          pageBuilder: (context, animtation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}
