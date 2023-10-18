import 'package:flutter/material.dart';
import 'package:townhall_todo/screens/add_todo/add_todo_screen.dart';
import 'package:townhall_todo/screens/add_todo/todo_added_screen.dart';
import 'package:townhall_todo/screens/home/category_screen.dart';
import 'package:townhall_todo/screens/navigation.dart';

class AppRouter {
  static _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Navigation.routeName:
        return _getPageRoute(const Navigation());

      case AddTodoScreen.routeName:
        return _getPageRoute(const AddTodoScreen());
      case TodoAddedScreen.routeName:
        return _getPageRoute(const TodoAddedScreen());

      case CategoryScreen.routeName:
        final title = settings.arguments as String;
        return _getPageRoute(CategoryScreen(title: title));
      default:
        return _getPageRoute(const Navigation());
    }
  }
}
