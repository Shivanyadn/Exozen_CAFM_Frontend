// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _employeeIdController = TextEditingController();

  Future<void> markAttendance(String action) async {
    final String employeeId = _employeeIdController.text.trim();

    if (employeeId.isEmpty) {
      // Show an alert if the employee ID is not entered
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please enter a valid Employee ID."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final Uri url = Uri.parse(
      action == 'check-in'
          ? 'http://localhost:5000/api/attendance/check-in'
          : 'http://localhost:5000/api/attendance/check-out',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode({"employeeId": employeeId}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Show success message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: Text(data['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        // Handle error response
        final Map<String, dynamic> data = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(data['message'] ?? 'Something went wrong!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Network error! Please try again later."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Employee ID input field
            TextField(
              controller: _employeeIdController,
              decoration: const InputDecoration(
                labelText: "Enter Employee ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            
            // Check-in button
            ListTile(
              title: const Text("Check In"),
              trailing: ElevatedButton(
                onPressed: () {
                  markAttendance('check-in'); // Call the API for check-in
                },
                child: const Text("Check In"),
              ),
            ),
            
            // Check-out button
            ListTile(
              title: const Text("Check Out"),
              trailing: ElevatedButton(
                onPressed: () {
                  markAttendance('check-out'); // Call the API for check-out
                },
                child: const Text("Check Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
