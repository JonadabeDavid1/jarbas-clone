import 'package:flutter/material.dart';
import 'package:jarbas_clone/home_page.dart';
import 'package:jarbas_clone/theme.dart';

void main() {
  runApp(const JarbasApp());
}

class JarbasApp extends StatelessWidget {
  const JarbasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jarbas Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
