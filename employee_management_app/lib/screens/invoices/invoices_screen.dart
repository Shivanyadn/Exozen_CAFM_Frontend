import 'package:flutter/material.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoices")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Invoice #1"),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                // Download invoice logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
