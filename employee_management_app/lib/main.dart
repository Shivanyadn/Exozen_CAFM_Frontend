import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/dashboard/admin_dashboard_screen.dart';
import 'screens/dashboard/user_dashboard.dart';
import 'screens/dashboard/manager_dashboard.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/reset_password_screen.dart';
import 'screens/auth/registration_screen.dart';
import 'screens/attendance/attendance_screen.dart';
import 'screens/payroll/payroll_screen.dart';
import 'screens/invoices/invoices_screen.dart';
import 'screens/kyc/kyc_screen.dart';
import 'screens/uniform/uniform_screen.dart';
import 'screens/id_card/id_card_screen.dart';

void main() => runApp(const EmployeeManagementApp());

class EmployeeManagementApp extends StatelessWidget {
  const EmployeeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/admin-dashboard': (context) => const AdminDashboardScreen(),
        '/user-dashboard': (context) => const UserDashboardScreen(),
        '/manager-dashboard': (context) => const ManagerDashboardScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/attendance': (context) => const AttendanceScreen(),
        '/payroll': (context) => const PayrollScreen(),
        '/invoices': (context) => const InvoicesScreen(),
        '/kyc': (context) => const KYCScreen(),
        '/uniform': (context) => const UniformScreen(),
        '/id_card': (context) => const IDCardScreen(),
      },
    );
  }
}
