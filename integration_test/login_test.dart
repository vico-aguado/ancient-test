import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:prueba_ancient/main.dart' as my_app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login test', () {
    testWidgets('Show fields correctly', (tester) async {
      // Load app widget.
      my_app.main();
      await tester.pumpAndSettle();

      // Finds the login field.
      expect(find.text('Login Now'), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('emailTextField')), 'vico@email.com');
      await tester.testTextInput.receiveAction(TextInputAction.next);

      await tester.enterText(
          find.byKey(const Key('passTextField')), 'vico1234');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.tap(find.byKey(const Key('loginButton')));

      await tester.pump(const Duration(milliseconds: 5000));

      await tester.pumpAndSettle();

      expect(find.text('Products'), findsOneWidget);

      await tester.pumpAndSettle();
    });
  });
}
