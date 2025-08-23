import 'package:flutter/material.dart';
import 'home_screen.dart' as home; // <-- import home screen
import 'calculator_screen.dart' as calc; // <-- import calculator screen
import 'inventory_screen.dart' as inventory; // <-- import inventory screen
import 'profile_screen.dart' as profile; // <-- import profile screen
import 'add_customer_screen.dart' as addCustomer; // <-- import add customer screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopkeeperMate',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Homepage(toggleTheme: _toggleTheme),
    );
  }
}

class Homepage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const Homepage({super.key, required this.toggleTheme});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    home.HomeScreen(), // Now using separate file
    calc.CalculatorScreen(),
    inventory.InventoryScreen(),
    profile.ProfileScreen(),
    addCustomer.AddCustomerScreen(),
  ];
    
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ShopkeeperMate',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,

          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          )
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Customer'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
