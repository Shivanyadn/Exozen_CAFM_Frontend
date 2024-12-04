// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> handlePasswordReset() async {
    final token = tokenController.text;
    final newPassword = newPasswordController.text;

    if (token.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token and new password cannot be empty")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final payload = {
      "token": token,
      "newPassword": newPassword,
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody['message'] == 'Password updated successfully') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully")),
        );

        // Optionally, navigate to the login screen or another page
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${responseBody['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: tokenController,
              decoration: const InputDecoration(labelText: "Reset Token"),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: handlePasswordReset,
                    child: const Text("Reset Password"),
                  ),
          ],
        ),
      ),
    );
  }
}
