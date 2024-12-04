import 'package:flutter/material.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manager Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Manager!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Add dashboard features specific to managers here
            ElevatedButton(
              onPressed: () {
                // Example action for manager
                Navigator.pushNamed(context, '/manage-employees');
              },
              child: const Text("Manage Employees"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Example action for manager
                Navigator.pushNamed(context, '/view-reports');
              },
              child: const Text("View Reports"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Log out action
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
