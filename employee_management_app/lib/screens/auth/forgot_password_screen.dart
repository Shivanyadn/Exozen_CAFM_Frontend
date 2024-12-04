// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:employee_management_app/services/api_service.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  final ApiService _apiService = ApiService(); // Create an instance of ApiService

  Future<void> handlePasswordResetRequest() async {
    final email = emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email cannot be empty")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Call the ApiService method to send the reset token
    final response = await _apiService.requestPasswordReset(email);

    if (response['message'] == 'Reset token sent to email') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("A reset token has been sent to your email")),
      );

      // Navigate to reset password screen
      Navigator.pushReplacementNamed(context, '/reset-password');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response['message']}")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: handlePasswordResetRequest,
                    child: const Text("Send Reset Token"),
                  ),
          ],
        ),
      ),
    );
  }
}
