// lib/home_screen.dart
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller = TextEditingController();
  String output = "0";
  int plusCount = 0;

  bool _isOp(String s) => s == '+' || s == '-' || s == '*' || s == '/';

  void _buttonPressed(String value) {
    if (value == "Back") {
      _handleBackspace();
      return;
    }

    setState(() {
      if (value == "C") {
        _controller.clear();
        output = "0";
        plusCount = 0;
        return;
      }

      if (value == "=") {
        final text = _controller.text;
        if (text.isEmpty) {
          output = "0";
          return;
        }
        if (_isOp(text[text.length - 1])) {
          _controller.text = text.substring(0, text.length - 1);
        }
        try {
          output = _calculate(_controller.text);
          _controller.text = output;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        } catch (_) {
          output = "Error";
        }
        return;
      }

      // handle operators
      if (_isOp(value)) {
        if (_controller.text.isEmpty) return;
        final text = _controller.text;
        if (_isOp(text[text.length - 1])) {
          _controller.text = text.substring(0, text.length - 1) + value;
        } else {
          _controller.text += value;
          if (value == "+") plusCount++;
        }
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
        output = _controller.text;
        return;
      }

      // digits
      _controller.text += value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
      output = _controller.text;
    });
  }

  void _handleBackspace() {
    final text = _controller.text;
    final cursorPos = _controller.selection.baseOffset;
    if (text.isEmpty || cursorPos == -1) return;

    final newText =
        text.substring(0, cursorPos - 1) + text.substring(cursorPos);
    _controller.text = newText;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorPos - 1));

    setState(() {
      output = _controller.text.isEmpty ? "0" : _controller.text;
    });
  }

  String _calculate(String expr) {
    final reg = RegExp(r'(\d+(\.\d+)?|[+\-*/])');
    final tokens = reg.allMatches(expr).map((m) => m.group(0)!).toList();
    if (tokens.isEmpty) return "0";

    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      final op = tokens[i];
      final numStr = (i + 1 < tokens.length) ? tokens[i + 1] : "0";
      final num = double.parse(numStr);
      switch (op) {
        case "+": result += num; break;
        case "-": result -= num; break;
        case "*": result *= num; break;
        case "/": if (num == 0) return "Error"; result /= num; break;
      }
    }
    final s = result.toString();
    return s.endsWith(".0") ? s.substring(0, s.length - 2) : s;
  }

  Widget _buildButton(String text, {Color? color}) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: color ?? Colors.blueGrey,
              padding: const EdgeInsets.all(20),
            ),
            onPressed: () => _buttonPressed(text),
            child: Text(text, style: const TextStyle(fontSize: 22)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Count: ${plusCount + 1}")),
      body: Column(
        children: [
          // Input box with cursor
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(output,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold)),
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
              _buildButton("Del", color: Colors.deepPurple), // new backspace
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.all(20)),
                    onPressed: () => Navigator.pushNamed(context, '/credit'),
                    child:
                        const Text("Credit", style: TextStyle(fontSize: 22)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.all(20)),
                    onPressed: () => Navigator.pushNamed(context, '/instant'),
                    child:
                        const Text("Instant", style: TextStyle(fontSize: 22)),
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
