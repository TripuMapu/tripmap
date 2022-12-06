import 'package:flutter/material.dart';
import 'package:tripmap/screens/contentscreen.dart';
import 'package:tripmap/screens/loginscreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final List<dynamic> args = settings.arguments as List<dynamic>;

    switch (settings.name) {
      case '/content':
        return CustomPageRoute(child: const ContentScreen());

      default:
        return CustomPageRoute(child: const LoginScreen());
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
