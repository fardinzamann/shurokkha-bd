import 'package:flutter/material.dart';
import 'sos_screen.dart';


void main() {
  runApp(const ShurokkhaApp());
}

class ShurokkhaApp extends StatelessWidget {
  const ShurokkhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shurokkha BD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passcodeController = TextEditingController();
  final String _secretCode = "2468"; // change this later!

  void _validateCode() {
  if (_passcodeController.text == _secretCode) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SOSScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Wrong code")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter Access Code", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 20),
              TextField(
                controller: _passcodeController,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Secret Code',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateCode,
                child: const Text("Enter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
