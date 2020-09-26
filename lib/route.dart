import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/news_screen.dart';

import 'pages/splash.dart';

class RouteGenerator {
  static Route<dynamic> gernerateRoutes(
    RouteSettings settings,
  ) {
    final arguments = settings.arguments;
    final route = settings.name;
    final removeBack = [
      '/',
      '/news_headline',
    ];

    return MaterialPageRoute(builder: (context) {
      return Stack(
        children: <Widget>[
          RouteWidget(route: route, arguments: arguments),
        ],
      );
    });
  }
}

class RouteWidget extends StatelessWidget {
  final dynamic route;
  final dynamic arguments;
  RouteWidget({this.route, this.arguments});

  @override
  Widget build(BuildContext context) {
    switch (route) {
      // case '/':
      //   return ProductList();

      case '/':
        return Splash();
      case '/news_headline':
        return NewsScreen();

      default:
        return Splash();
    }
  }
}
