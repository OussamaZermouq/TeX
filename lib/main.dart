import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tex/app/data/service/profile_serivce.dart';
import 'package:tex/screens/home_screen.dart';
import 'package:tex/screens/introduce_screen.dart';
import 'package:tex/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TeXApp());
}

class TeXApp extends StatelessWidget {
  const TeXApp({super.key});

  //for testing purposes
  Future<void> setPrefs() async{
    final refs = await SharedPreferences.getInstance();
    //for testing remove later
    refs.setString('userId', "1ef88e85-a07b-6720-acdd-b77ec5e6171a");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeX App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x0028262C)),
        useMaterial3: true,
        fontFamily: 'SFPro',
      ),
      routes: {
        '/welcome': (context) => const HomeScreen(),
      },
      initialRoute: '/welcome',
    );
  }
}
