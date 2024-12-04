// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:employee_management_app/services/api_service.dart';
import 'package:employee_management_app/screens/uniform/uniform_screen.dart'; // Import the uniform screen

class IDCardScreen extends StatefulWidget {
  const IDCardScreen({super.key});

  @override
  _IDCardScreenState createState() => _IDCardScreenState();
}

class _IDCardScreenState extends State<IDCardScreen> {
  final TextEditingController _controller = TextEditingController(); // Controller for TextField
  String employeeId = ""; // To store employee ID

  // Function to handle ID Card request
  Future<void> requestIDCard(BuildContext context) async {
    try {
      if (employeeId.isEmpty) {
        // Show error if employee ID is empty
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a valid Employee ID."),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Call the API service method
      final responseData = await ApiService.generateIdCard(employeeId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['message']),
          duration: const Duration(seconds: 3),
        ),
      );

      // Optionally, display the ID Card details
      if (responseData['idCard'] != null) {
        final cardDetails = responseData['idCard'];
        
        // Show dialog for ID Card Generation and Uniform Request
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("ID Card Generated"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("ID Card URL: ${cardDetails['cardUrl']}"),
                  Text("Generated At: ${cardDetails['generatedAt']}"),
                  const SizedBox(height: 20),
                  const Text("Your ID is generated. Please request your uniform."),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigate to the uniform screen when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UniformScreen()),
                    );
                  },
                  child: const Text("Request Uniform"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle API errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ID Card Request"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "KYC is approved. Please proceed with your ID card request.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Search bar for employee ID
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Employee ID',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  employeeId = value; // Update employee ID as user types
                });
              },
            ),
            const SizedBox(height: 20),

            // Request ID Card Button
            ElevatedButton(
              onPressed: () => requestIDCard(context), // Call the request function
              child: const Text("Request ID Card"),
            ),
          ],
        ),
      ),
    );
  }
}
