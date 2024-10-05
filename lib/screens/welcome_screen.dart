import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'screens.dart';
import 'package:flutter/foundation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const TextStyle welcomeStyle = TextStyle(
      fontSize: 24,
    );
    Image image = Image.asset(
      "assets/images/TeX_Logo.png",
      filterQuality: FilterQuality.high,
      scale: 3.0,
      height: 200,
      width: 200,
    );
    var welcomeColumn =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("TeX", style: welcomeStyle),
      image,
      FilledButton.tonalIcon(
          label: const Text(
            'Continue',
            style: const TextStyle(fontSize: 17),
          ),
          icon: const Icon(
            LucideIcons.arrowRight,
            size: 20,
          ),
          iconAlignment: IconAlignment.end,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          })
    ]);

    return Scaffold(body: SafeArea(child: Center(child: welcomeColumn)));
  }
}
