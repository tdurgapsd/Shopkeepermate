// lib/home_screen.dart
// import 'package:flutter/material.dart';

// class CalculatorScreen extends StatelessWidget {
//   const CalculatorScreen({super.key}); // null-safety

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Calculator Screen',
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// lib/home_screen.dart
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _input = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _input = "";
        output = "0";
      } else if (value == "=") {
        try {
          output = _calculate(_input);
          _input = output;
        } catch (e) {
          output = "Error";
        }
      } else {
        _input += value;
        output = _input;
      }
    });
  }

  String _calculate(String input) {
    // simple eval for +, -, *, /
    final tokens = input.split(RegExp(r'([+\-*/])')).map((e) => e.trim()).toList();
    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double num = double.parse(tokens[i + 1]);
      if (op == "+") result += num;
      if (op == "-") result -= num;
      if (op == "*") result *= num;
      if (op == "/") result /= num;
    }
    return result.toString();
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blueGrey,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => _buttonPressed(text),
          child: Text(text, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(output, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton("0"),
              _buildButton("C", color: Colors.red),
              _buildButton("=", color: Colors.green),
              _buildButton("+", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/credit'); // navigate to credit section
                    },
                    child: const Text("Credit", style: TextStyle(fontSize: 22)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/instant'); // navigate to instant section
                    },
                    child: const Text("Instant", style: TextStyle(fontSize: 22)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
