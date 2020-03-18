// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Demp App', () {
    final skipLoginButtonFinder = find.byValueKey('skipLogin');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('tap on skip login button', () async {
      // First, tap the button.
      await driver.tap(skipLoginButtonFinder);

      //Check if the navigation is done correctly
      await driver.waitFor(find.text("Draft Home"));
    });

    test('tap on change password button', () async {
      // First, tap the button.
      final changePasswordButtonFinder = find.byValueKey('changePassword');
      await driver.tap(changePasswordButtonFinder);

      //Check if the navigation is done correctly
      await driver.waitFor(find.text("Change Password"));
    });

    test('tap on change password button', () async {
      // First, tap the button.
      final changePasswordButtonFinder = find.byValueKey('changePassword');
      await driver.tap(changePasswordButtonFinder);

      //Check if the navigation is done correctly
      await driver.waitFor(find.byValueKey("snackbar"));
    });
  });
}
