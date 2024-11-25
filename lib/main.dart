import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tex/app/data/service/profile_serivce.dart';
import 'package:tex/screens/chat_screen.dart';
import 'package:tex/screens/home_screen.dart';
import 'package:tex/screens/introduce_screen.dart';
import 'package:tex/screens/login_screen.dart';
import 'package:tex/screens/screens.dart';
import 'package:tex/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TeXApp());
}

class TeXApp extends StatelessWidget {
  const TeXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeX App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      routes: {
        '/welcome': (context) => const HomeScreen(),
      },
      initialRoute: '/welcome',
    );
  }
}
