// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employee_management_app/services/api_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> handleLogin(BuildContext context) async {
  final email = emailController.text;
  final password = passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email and password cannot be empty")),
    );
    return;
  }

  final payload = {
    "email": email,
    "password": password,
  };

  try {
    final response = await ApiService.loginUser(payload);

    if (response['token'] != null) {
      final token = response['token'];
      final role = response['role'];  // Extract role from the response

      // Store the token in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      // Navigate based on the role
      if (role == 'Admin') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful as Admin!")),
        );
        Navigator.pushReplacementNamed(context, '/admin-dashboard');
      } else if (role == 'Manager') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful as Manager!")),
        );
        Navigator.pushReplacementNamed(context, '/manager-dashboard');
      } else if (role == 'User') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful as User!")),
        );
        Navigator.pushReplacementNamed(context, '/user-dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unknown role. Login failed.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${response['message']}")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                handleLogin(context); // Call the login method
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot-password'); // Navigate to forgot password screen
              },
              child: const Text("Forgot Password?"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navigate to register page
              },
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
