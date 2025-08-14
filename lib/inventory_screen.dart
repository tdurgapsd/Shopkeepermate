// lib/home_screen.dart
import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key}); // null-safety

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Inventory Screen',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
