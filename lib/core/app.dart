import 'package:flutter/material.dart';

import '../ui/screens/main_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
      ),
      home: const MainScreen(),
    );
  }
}
