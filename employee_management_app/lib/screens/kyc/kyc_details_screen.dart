// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:employee_management_app/services/api_service.dart';

class KYCDetailsScreen extends StatefulWidget {
  const KYCDetailsScreen({super.key});

  @override
  _KYCDetailsScreenState createState() => _KYCDetailsScreenState();
}

class _KYCDetailsScreenState extends State<KYCDetailsScreen> {
  final TextEditingController employeeIdController = TextEditingController();
  Map<String, dynamic> kycData = {};
  String errorMessage = '';

  // Function to fetch KYC details by employee ID
  void _fetchKYCDetails() async {
    setState(() {
      errorMessage = ''; // Clear any previous error message
    });

    try {
      final response = await ApiService.fetchKYCDetails(employeeIdController.text);
      if (response['message'] == 'KYC form retrieved successfully') {
        setState(() {
          kycData = response['kycData']; // Store KYC data
        });
      } else {
        setState(() {
          errorMessage = 'No data found for the given employee ID';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch KYC details. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KYC Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: employeeIdController,
              decoration: const InputDecoration(
                labelText: 'Employee ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchKYCDetails,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            if (kycData.isNotEmpty) ...[
              Text('Employee ID: ${kycData['employeeId']}'),
              Text('First Name: ${kycData['firstName']}'),
              Text('Last Name: ${kycData['lastName']}'),
              Text('Address: ${kycData['address']}'),
              Text('Phone Number: ${kycData['phoneNumber']}'),
              Text('Email: ${kycData['email']}'),
              Text('Date of Birth: ${kycData['dateOfBirth']}'),
              Text('ID Proof: ${kycData['idProof']}'),
              Text('Status: ${kycData['status']}'),
            ],
          ],
        ),
      ),
    );
  }
}
