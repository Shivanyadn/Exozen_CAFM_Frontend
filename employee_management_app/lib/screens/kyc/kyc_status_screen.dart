// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:employee_management_app/services/api_service.dart';
import 'package:employee_management_app/screens/id_card/id_card_screen.dart';

class KYCStatusScreen extends StatefulWidget {
  const KYCStatusScreen({super.key});

  @override
  _KYCStatusScreenState createState() => _KYCStatusScreenState();
}

class _KYCStatusScreenState extends State<KYCStatusScreen> {
  final TextEditingController _controller = TextEditingController();
  String _statusMessage = "";
  bool _isLoading = false;

  final ApiService apiService = ApiService(); // Initialize API service

  // Fetch KYC status based on employeeId
  Future<void> _searchKYCStatus(String employeeId) async {
    setState(() {
      _isLoading = true;
      _statusMessage = "";
    });

    try {
      final data = await apiService.fetchKYCStatus(employeeId);

      setState(() {
        if (data.containsKey('error')) {
          _statusMessage = data['error'];  // Show error message if any
        } else {
          final kycStatus = data['status'];  // Correctly accessing the 'status' field inside kycData

          if (kycStatus == 'Approved') {
            _statusMessage = "KYC Approved. Request for ID Card.";
            // Show dialog after KYC approval
            _showKYCApprovalDialog();
          } else if (kycStatus == 'Rejected') {
            _statusMessage = "KYC Rejected. Please contact the admin.";
          } else {
            _statusMessage = "KYC status Pending.";
          }
        }
      });
    } catch (e) {
      setState(() {
        _statusMessage = "An error occurred: $e";
      });
      print('Error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showKYCApprovalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("KYC Approved"),
          content: const Text(
            "KYC is approved. Please proceed with your ID card request.",
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to ID Card screen after approval
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IDCardScreen()),
                );
              },
              child: const Text("Request ID Card"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KYC Status")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar for employee ID input
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Employee ID',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final employeeId = _controller.text.trim();
                    if (employeeId.isNotEmpty) {
                      _searchKYCStatus(employeeId);
                    } else {
                      setState(() {
                        _statusMessage = "Please enter an employee ID.";
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Show loading spinner or status message
            _isLoading
                ? const CircularProgressIndicator()
                : Text(_statusMessage, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
