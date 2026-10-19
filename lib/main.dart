import 'package:flutter/material.dart';
import 'package:barricapp/features/cava/screens/home_scaffold.dart';

void main() {
  runApp(const BarricApp());
}

class BarricApp extends StatelessWidget {
  const BarricApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarricApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScaffold(),
    );
  }
}
