import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){
  group('Counter App',(){

    FlutterDriver driver;

    //finders
    final usernameField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final signInButton = find.byValueKey('signIn');
    final signOutButton = find.byValueKey('signOut');
    final createAccountButton = find.byValueKey('createAccount');
    final addTodoField = find.byValueKey('addTodoField');
    final addTodoButton = find.byValueKey('addTodoButton');

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

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    test('create account', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("felix@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("123456");

      await driver.tap(createAccountButton);
      await driver.waitFor(find.text("Your Todo's"));
    });

    test('login', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("felix@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("123456");

      await driver.tap(signInButton);
      await driver.waitFor(find.text("Your Todo's"));
    });

    test('add a todo', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(addTodoField);
        await driver.enterText("make an integration test video");
        await driver.tap(addTodoButton);

        await driver.waitFor(find.text("make an integration test video"),
            timeout: const Duration(seconds: 3));
      }
    });
  });
}
