import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:discrete_math/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('From Login to SignUp', () {
    testWidgets("Тестування не перехід на інший екран", (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));
      final buttonSignUp = find.byKey(const Key('goto_signup'));
      expect(buttonSignUp, findsOneWidget);
      await tester.tap(buttonSignUp);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('SIGN UP'), findsOneWidget);

      final buttonLoginT = find.byKey(const Key('goto_login'));
      expect(buttonLoginT, findsOneWidget);
      await tester.tap(buttonLoginT);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('LOG IN'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 10));
      final emailField = find.byKey(const Key('email_field'));
      final passwordField = find.byKey(const Key('password_field'));
      final buttonLogin = find.byKey(const Key('login_button'));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(buttonLogin, findsOneWidget);

      await tester.enterText(emailField, 'test@gmail.com');
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(buttonLogin);

      await tester.pumpAndSettle(const Duration(seconds: 10));
      expect(find.text('Your Graphs'), findsOneWidget);
    });
  });
  // group('Login Flow', () {
  //   testWidgets("Тестування не перехід на інший екран", (
  //     WidgetTester tester,
  //   ) async {
  //     app.main();
      
  //   });
  // });
}
