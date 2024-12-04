import 'package:flutter/material.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Greeting with Avatar
              const Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Welcome, User!",
                    style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Roadmap Section
              const Text(
                "Your Roadmap:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Roadmap Steps
              _buildRoadmapStep(
                context,
                "1. Complete KYC",
                '/kyc',
                "Submit your KYC documents.",
                Icons.file_upload,
                status: "In Progress",
              ),
              _buildRoadmapStep(
                context,
                "2. Request ID Card",
                '/id_card',
                "Request your ID card after KYC approval.",
                Icons.credit_card,
                status: "Not Started",
              ),
              _buildRoadmapStep(
                context,
                "3. Request Uniform",
                '/uniform',
                "Request a uniform after ID card issuance.",
                Icons.checkroom,
                status: "Not Started",
              ),
              _buildRoadmapStep(
                context,
                "4. Punch In/Out Attendance",
                '/attendance',
                "Track your attendance by punching in and out.",
                Icons.access_time,
                status: "Not Started",
              ),
              _buildRoadmapStep(
                context,
                "5. View Reports",
                '/reports',
                "Access your daily, weekly, and monthly reports.",
                Icons.assessment,
                status: "Not Started",
              ),
              _buildRoadmapStep(
                context,
                "6. View Payslip",
                '/view_payslip',
                "View your payslip for the current or previous month.",
                Icons.receipt,
                status: "Not Started",
              ),
              const SizedBox(height: 30),

              // Logout Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Log out action
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build each roadmap step
  Widget _buildRoadmapStep(BuildContext context, String stepTitle, String route, String description, IconData icon, {String status = "Not Started"}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.black.withOpacity(0.1),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Icon(icon, size: 50, color: _getIconColor(status)),
          title: Text(stepTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description, style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              _buildProgressBar(status),
            ],
          ),
          trailing: _buildStatusBadge(status),
          onTap: () {
            // Navigate to the respective screen for each step
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }

  // Helper to get icon color based on status
  Color _getIconColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // Helper to build a status badge for each step
  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper to return color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // Add a progress bar under each roadmap step
  Widget _buildProgressBar(String status) {
    double progress = 0.0;
    if (status == "Completed") {
      progress = 1.0;
    } else if (status == "In Progress") {
      progress = 0.5;
    }

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(status)),
    );
  }
}
