import 'package:flutter/material.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payroll Management")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("View Payslip"),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                // Download payslip logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
