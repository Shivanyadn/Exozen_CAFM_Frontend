import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Log out the admin and navigate to the login screen
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(  // Wrap the Column in SingleChildScrollView to allow scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to the Admin Dashboard!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Here you can manage users, view reports, and configure settings.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            // Grid of dashboard cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,  // Allow the GridView to take up the available space in the scroll view
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                _DashboardCard(
                  icon: Icons.people,
                  title: 'Manage Users',
                  onTap: () {
                    // Navigate to the user management screen
                    Navigator.pushNamed(context, '/manage-users');
                  },
                ),
                _DashboardCard(
                  icon: Icons.bar_chart,
                  title: 'View Reports',
                  onTap: () {
                    // Navigate to the reports screen
                    Navigator.pushNamed(context, '/reports');
                  },
                ),
                _DashboardCard(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Navigate to the settings screen
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                _DashboardCard(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    // Navigate to the help & support screen
                    Navigator.pushNamed(context, '/help');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
