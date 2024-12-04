import 'package:flutter/material.dart';
import 'new_kyc_screen.dart';
import 'kyc_status_screen.dart';
import 'kyc_details_screen.dart';

class KYCScreen extends StatelessWidget {
  const KYCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KYC Management")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Create New KYC Submission"),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewKYCScreen()),
                );
              },
              child: const Text("Submit New"),
            ),
          ),
          ListTile(
            title: const Text("Check KYC Status"),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KYCStatusScreen()),
                );
              },
              child: const Text("Check Status"),
            ),
          ),
          ListTile(
            title: const Text("Get KYC Details"),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KYCDetailsScreen()),
                );
              },
              child: const Text("View Details"),
            ),
          ),
        ],
      ),
    );
  }
}
