// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:employee_management_app/services/api_service.dart';

class UniformScreen extends StatefulWidget {
  const UniformScreen({super.key});

  @override
  _UniformScreenState createState() => _UniformScreenState();
}

class _UniformScreenState extends State<UniformScreen> {
  final TextEditingController _employeeIdController = TextEditingController();

  Future<void> requestUniform(String employeeId, String type, String size) async {
    final apiService = ApiService();
    final response = await apiService.requestUniform(employeeId, type, size);

    if (response['success']) {
      // If successful, print the uniform request data
      print('Uniform request submitted successfully: ${response['data']}');
    } else {
      // If there's an error, print the error message
      print('Error: ${response['message']}');
    }
  }

  void _showUniformDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController typeController = TextEditingController();
        final TextEditingController sizeController = TextEditingController();

        return AlertDialog(
          title: const Text('Enter Uniform Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Uniform Type (e.g., Shirt)'),
              ),
              TextField(
                controller: sizeController,
                decoration: const InputDecoration(labelText: 'Uniform Size (e.g., M)'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (typeController.text.isNotEmpty && sizeController.text.isNotEmpty) {
                  requestUniform(_employeeIdController.text, typeController.text, sizeController.text);
                  Navigator.of(context).pop();
                } else {
                  // Show an error message if the fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter both uniform type and size')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _searchEmployeeId() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Employee ID'),
          content: TextField(
            controller: _employeeIdController,
            decoration: const InputDecoration(labelText: 'Employee ID'),
            keyboardType: TextInputType.text,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_employeeIdController.text.isNotEmpty) {
                  Navigator.of(context).pop();
                  _showUniformDialog(); // Show the dialog to enter uniform details
                } else {
                  // Show an error message if Employee ID is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid Employee ID')),
                  );
                }
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Uniform Management")),
      body: Center(
        child: ElevatedButton(
          onPressed: _searchEmployeeId,  // Call the search function
          child: const Text("Search Employee ID"),
        ),
      ),
    );
  }
}
