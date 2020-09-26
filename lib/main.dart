import 'package:flutter/material.dart';
import 'package:news_app/pages/news_screen.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/route.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        title: 'News',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.gernerateRoutes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
