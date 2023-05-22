import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/auth/Authentication.dart';
import 'package:rate_it/model/user.dart';
import 'package:rate_it/screens/login_page.dart';
import 'package:rate_it/screens/settings-subclasses.dart';
import 'package:rate_it/screens/settings.dart';

void main() {
  group('SettingsPage Tests', () {
    late User mockUser;

    setUp(() {
      // Set up mock User data for testing
      mockUser = User(
        uid: "",
        email: "f@g.com",
        firstName: "Francisco",
        lastName: "Campos",
        username: "ffffffffff",
        // Fill in the necessary properties for the mock user
        isPrivate: true,
      );
    });

    testWidgets('Renders with the correct title', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsPage(user: mockUser)));

      // Verify that the page title is rendered correctly
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Renders the General section with a Switch', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsPage(user: mockUser)));

      // Verify that the General section title is rendered correctly
      expect(find.text('General'), findsOneWidget);

      // Verify that the CustomListTile with a Switch is rendered
      expect(find.byIcon(FontAwesomeIcons.shieldHalved), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('Renders the Edit Profile section with CustomListTiles', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsPage(user: mockUser)));

      // Verify that the Edit Profile section title is rendered correctly
      expect(find.text('Edit Profile'), findsOneWidget);

      // Verify that the CustomListTiles for each Edit Profile option are rendered
      expect(find.byIcon(FontAwesomeIcons.addressCard), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.pencil), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.phone), findsOneWidget);
    });

    testWidgets('Renders the Security section with CustomListTiles', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsPage(user: mockUser)));

      // Verify that the Security section title is rendered correctly
      expect(find.text('Security'), findsOneWidget);

      // Verify that the CustomListTiles for each Security option are rendered
      expect(find.byIcon(FontAwesomeIcons.envelope), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.user), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.key), findsOneWidget);
    });

    testWidgets('Renders the Sign out option', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsPage(user: mockUser)));

      // Verify that the Sign out option is rendered correctly
      expect(find.byIcon(FontAwesomeIcons.arrowRightFromBracket), findsOneWidget);
    });

    testWidgets('Tapping on the Sign out option triggers the logout process', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsPage(user: mockUser)));

      // Tap on the Sign out option
      await tester.tap(find.byIcon(FontAwesomeIcons.arrowRightFromBracket));
      await tester.pumpAndSettle();

    });
  });
}
