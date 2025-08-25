// lib/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme; // 👈 to switch theme

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("ShopkeeperMate"),
        // centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.brightness_6),
        //     onPressed: toggleTheme, // 👈 theme toggle button
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Welcome to ShopkeeperMate 👋",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Your smart partner to manage inventory, sales, credits, customer details and vendor details with ease.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Feature Cards Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildFeatureCard(Icons.inventory, "Inventory"),
                  _buildFeatureCard(Icons.attach_money, "Credit Tracking"),
                  _buildFeatureCard(Icons.bar_chart, "Data Visualization"),
                  _buildFeatureCard(Icons.receipt, "Sales Reports"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // TODO: Add navigation later
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
