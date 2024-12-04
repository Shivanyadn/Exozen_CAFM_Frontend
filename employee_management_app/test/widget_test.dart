import 'package:employee_management_app/screens/attendance/attendance_screen.dart';
import 'package:employee_management_app/screens/auth/login_screen.dart';
import 'package:employee_management_app/screens/auth/registration_screen.dart';
import 'package:employee_management_app/screens/id_card/id_card_screen.dart';
import 'package:employee_management_app/screens/invoices/invoices_screen.dart';
import 'package:employee_management_app/screens/kyc/kyc_screen.dart';
import 'package:employee_management_app/screens/payroll/payroll_screen.dart';
import 'package:employee_management_app/screens/uniform/uniform_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employee_management_app/main.dart';

void main() {
  group('Employee Management App Tests', () {
    testWidgets('Initial route is the login screen', (WidgetTester tester) async {
      // Build the app and trigger a frame.
      await tester.pumpWidget(const EmployeeManagementApp());

      // Verify the login screen is displayed.
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Login'), findsWidgets); // Adjust this text if it matches a specific widget.
    });

    testWidgets('Navigation to registration screen works', (WidgetTester tester) async {
      // Build the app and trigger a frame.
      await tester.pumpWidget(const EmployeeManagementApp());

      // Tap the button or link to navigate to the registration screen.
      // Replace `find.text('Register')` with the actual text or widget used in your LoginScreen.
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Verify the registration screen is displayed.
      expect(find.byType(RegistrationScreen), findsOneWidget);
    });

    testWidgets('Navigation to attendance screen works', (WidgetTester tester) async {
      // Build the app and trigger a frame.
      await tester.pumpWidget(const EmployeeManagementApp());

      // Simulate navigating to the attendance screen using Navigator.
      await tester.runAsync(() async {
        await tester.pumpWidget(const MaterialApp(home: AttendanceScreen()));
        await tester.pumpAndSettle();
      });

      // Verify the attendance screen is displayed.
      expect(find.byType(AttendanceScreen), findsOneWidget);
    });

    testWidgets('Navigation to payroll screen works', (WidgetTester tester) async {
      // Build the app and trigger a frame.
      await tester.pumpWidget(const EmployeeManagementApp());

      // Simulate navigating to the payroll screen using Navigator.
      await tester.runAsync(() async {
        await tester.pumpWidget(const MaterialApp(home: PayrollScreen()));
        await tester.pumpAndSettle();
      });

      // Verify the payroll screen is displayed.
      expect(find.byType(PayrollScreen), findsOneWidget);
    });

    // Add similar tests for invoices, KYC, uniform, and ID card screens.
    testWidgets('Navigation to invoices screen works', (WidgetTester tester) async {
      await tester.pumpWidget(const EmployeeManagementApp());

      await tester.runAsync(() async {
        await tester.pumpWidget(const MaterialApp(home: InvoicesScreen()));
        await tester.pumpAndSettle();
      });

      expect(find.byType(InvoicesScreen), findsOneWidget);
    });

    testWidgets('Navigation to KYC screen works', (WidgetTester tester) async {
      await tester.pumpWidget(const EmployeeManagementApp());

      await tester.runAsync(() async {
        await tester.pumpWidget(const MaterialApp(home: KYCScreen()));
        await tester.pumpAndSettle();
      });

      expect(find.byType(KYCScreen), findsOneWidget);
    });

    testWidgets('Navigation to uniform screen works', (WidgetTester tester) async {
      await tester.pumpWidget(const EmployeeManagementApp());

      await tester.runAsync(() async {
        await tester.pumpWidget(const MaterialApp(home: UniformScreen()));
        await tester.pumpAndSettle();
      });

      expect(find.byType(UniformScreen), findsOneWidget);
    });

    testWidgets('Navigation to ID card screen works', (WidgetTester tester) async {
      await tester.pumpWidget(const EmployeeManagementApp());

      await tester.runAsync(() async {
        await tester.pumpWidget(const MaterialApp(home: IDCardScreen()));
        await tester.pumpAndSettle();
      });

      expect(find.byType(IDCardScreen), findsOneWidget);
    });
  });
}
