import 'package:flutter/material.dart';

void main() {
  runApp(const AutoAlDiaApp());
}

class AutoAlDiaApp extends StatelessWidget {
  const AutoAlDiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoAlDía',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const Scaffold(
        body: Center(child: Text('AutoAlDía')),
      ),
    );
  }
}