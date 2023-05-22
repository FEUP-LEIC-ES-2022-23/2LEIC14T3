import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_it/screens/login_page.dart';
import 'package:rate_it/screens/header_page.dart';
import 'package:rate_it/screens/register_page.dart';
import 'package:rate_it/widgets/popup_message.dart';

void main() {
  testWidgets('LoginPage form validation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Verify that the initial state of the form is invalid
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);

    // Enter invalid email and password
    await tester.enterText(find.byType(TextFormField).first, 'invalid_email');
    await tester.enterText(find.byType(TextFormField).last, '');

    // Tap the login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that validation error messages are displayed
    expect(find.text('Invalid email format'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    // Enter valid email and password
    await tester.enterText(find.byType(TextFormField).first, 'valid_email@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'password123');

    // Tap the login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that the form is submitted successfully
    expect(find.byType(PopupMessage), findsNothing);
  });

  testWidgets('LoginPage navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Tap the create account button
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    // Verify that the register page is displayed
    expect(find.byType(RegisterPage), findsOneWidget);
  });
}
