// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:employee_management_app/services/api_service.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = "User "; // Default role
  final List<String> roles = ["User ", "Admin", "Manager"];
  final List<String> projects = ["Project A", "Project B", "Project C"];
  List<String> selectedProjects = [];

  Future<void> handleRegistration(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedProjects.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    final payload = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": selectedRole,
      "projects": selectedProjects,
    };

    try {
      final response = await ApiService.registerUser (payload);

      if (response['success'] == true) {
        final userName = response['data']['name'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful! Welcome, $userName")),
        );
        Navigator.pushNamed(context, '/'); // Redirect to login or home page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${response['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(nameController, "Name", Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(emailController, "Email", Icons.email),
                  const SizedBox(height: 16),
                  _buildTextField(passwordController, "Password", Icons.lock, obscureText: true),
                  const SizedBox(height: 20),
                  _buildRoleDropdown(),
                  const SizedBox(height: 20),
                  _buildProjectsSelector(),
                  const SizedBox(height: 20),
                  _buildRegisterButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: InputDecoration(
        labelText: "Select Role",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: roles.map ((role) {
        return DropdownMenuItem(value: role, child: Text(role));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedRole = value!;
        });
      },
    );
  }

  Widget _buildProjectsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Projects",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: projects.map((project) {
            final isSelected = selectedProjects.contains(project);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedProjects.remove(project);
                  } else {
                    selectedProjects.add(project);
                  }
                });
              },
              child: Chip(
                label: Text(project),
                backgroundColor: isSelected ? Colors.blueAccent : Colors.grey[200],
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => handleRegistration(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
      ),
      child: const Text(
        "Register",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}