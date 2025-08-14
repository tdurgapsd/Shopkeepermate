// lib/home_screen.dart
import 'package:flutter/material.dart';


class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key}); // null-safety

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add Customer Screen',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
