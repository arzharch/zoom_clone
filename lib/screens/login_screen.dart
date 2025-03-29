import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    // Attempt to sign in with Google
    bool res = await _authMethods.signInWithGoogle(context);
    // If sign-in is successful and widget is still mounted, navigate to home.
    if (res && mounted) {
      Navigator.pushNamed(context, '/home');
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Use SingleChildScrollView to handle overflow on smaller screens.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Start or join a meeting',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 38.0),
                child: Image.asset('assets/images/onboarding.jpg'),
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                    text: 'Google Sign In',
                    onPressed: _handleGoogleSignIn,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
