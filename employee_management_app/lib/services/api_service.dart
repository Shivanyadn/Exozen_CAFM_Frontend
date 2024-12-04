import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000/api"; // Base URL for your API

  // Registration API
  static Future<Map<String, dynamic>> registerUser(Map<String, dynamic> payload) async {
    final url = Uri.parse('$baseUrl/auth/register');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'Registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // Login API
  static Future<Map<String, dynamic>> loginUser(Map<String, dynamic> payload) async {
    final url = Uri.parse('$baseUrl/auth/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  static Future<Map<String, dynamic>> checkAdminStatus(String token) async {
    final url = Uri.parse('http://localhost:5000/api/auth/admin-only');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add token in the header
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'message': 'Failed to verify admin status'};
      }
    } catch (e) {
      return {'message': 'Error occurred: $e'};
    }
  }

  // Define the checkUserRole method
  static Future<Map<String, dynamic>> checkUserRole(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/check-role'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check user role');
    }
  }

// Method for password reset request (Forgot Password)
  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    final url = Uri.parse('$baseUrl/request-reset');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'message': 'Failed to send reset token: ${response.body}',
        };
      }
    } catch (e) {
      return {
        'message': 'Error occurred: $e',
      };
    }
  }

  // Method to reset the password using the token and new password
  Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
    final url = Uri.parse('$baseUrl/reset-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'token': token,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'message': 'Failed to reset password: ${response.body}',
        };
      }
    } catch (e) {
      return {
        'message': 'Error occurred: $e',
      };
    }
  }

  // KYC Submit API
  static Future<Map<String, dynamic>> submitKYC(Map<String, dynamic> payload) async {
    final url = Uri.parse('$baseUrl/kyc/submit');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'KYC submission failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // Fetch KYC details by employee ID
  static Future<Map<String, dynamic>> fetchKYCDetails(String employeeId) async {
    final url = Uri.parse('$baseUrl/kyc/$employeeId');
    
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch KYC details'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

 Future<Map<String, dynamic>> fetchKYCStatus(String employeeId) async {
  final url = Uri.parse('$baseUrl/kyc/$employeeId');
  try {
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Ensure data['kycData'] exists before accessing
      if (data['kycData'] != null) {
        return {
          'status': data['kycData']['status'], // Extract status from kycData
          'message': data['message'],
          'kycData': data['kycData'],
        };
      } else {
        return {'error': 'No KYC data found'};
      }
    } else {
      return {'error': 'Failed to load KYC data'};
    }
  } catch (e) {
    return {'error': 'An error occurred: $e'};
  }
}

 // Function to request ID Card generation
static Future<Map<String, dynamic>> generateIdCard(String employeeId) async {
  final String apiUrl = '$baseUrl/id-cards/$employeeId/generate'; // Use baseUrl instead of _baseUrl

  try {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the success response
    } else {
      // Handle errors
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  } catch (e) {
    // Throw exceptions for calling code to handle
    throw Exception("Failed to generate ID Card: $e");
  }
}


// Function to request uniform
  Future<Map<String, dynamic>> requestUniform(String employeeId, String uniformType, String size) async {
    final url = Uri.parse('$baseUrl/uniforms/$employeeId/submit');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'uniformType': uniformType,
      'size': size,
    });

    try {
      // Send POST request to the backend
      final response = await http.post(url, headers: headers, body: body);

      // Check if the request was successful
      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': json.decode(response.body)['uniformRequest'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to submit uniform request: ${response.statusCode}',
        };
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'Error submitting uniform request: $error',
      };
    }
  }
}
