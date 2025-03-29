import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onLogout;

  // Pass the 'key' to the superclass constructor directly
  const HomeScreen({required this.onLogout, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'I logged in successfully!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: onLogout, child: const Text('Log Out')),
          ],
        ),
      ),
    );
  }
}
