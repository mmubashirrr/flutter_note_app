// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notes_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _error = '';

  void _signupUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NotesScreen()));
    } catch (e) {
      setState(() {
        _error = 'Signup failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (_error.isNotEmpty) Text(_error, style: TextStyle(color: Colors.red)),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _signupUser, child: Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}
