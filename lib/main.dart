import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x0028262C)),
        useMaterial3: true,
        fontFamily: 'SFPro',
      ),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
      },
      initialRoute: '/welcome',
    );
  }
}
