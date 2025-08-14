// lib/home_screen.dart
import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key}); // null-safety

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Calculator Screen',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
