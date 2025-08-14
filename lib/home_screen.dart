// lib/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // null-safety

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to ShopkeeperMate!',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
