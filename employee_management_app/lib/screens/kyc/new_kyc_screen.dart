// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:employee_management_app/screens/kyc/kyc_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:employee_management_app/services/api_service.dart';

class NewKYCScreen extends StatefulWidget {
  const NewKYCScreen({super.key});

  @override
  _NewKYCScreenState createState() => _NewKYCScreenState();
}

class _NewKYCScreenState extends State<NewKYCScreen> {
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController idProofController = TextEditingController();
void _submitForm() async {
  final response = await ApiService.submitKYC({
    'employeeId': employeeIdController.text,
    'firstName': firstNameController.text,
    'lastName': lastNameController.text,
    'address': addressController.text,
    'phoneNumber': phoneNumberController.text,
    'email': emailController.text,
    'dateOfBirth': dateOfBirthController.text,
    'idProof': idProofController.text,
  });

  if (response['message'] == 'KYC form submitted successfully') {
    // If KYC submission is successful, show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('KYC Submitted Successfully')),
    );
    
    // Navigate to the Details Screen after successful submission
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const KYCDetailsScreen()),
    );
  } else {
    // Show an error message if submission fails
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to submit KYC form')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submit New KYC")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: employeeIdController,
              decoration: const InputDecoration(labelText: "Employee ID"),
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: dateOfBirthController,
              decoration: const InputDecoration(labelText: "Date of Birth (YYYY-MM-DD)"),
            ),
            TextField(
              controller: idProofController,
              decoration: const InputDecoration(labelText: "ID Proof"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Submit KYC"),
            ),
          ],
        ),
      ),
    );
  }
}
