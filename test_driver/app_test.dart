// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
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

  group('Happy paths', () {

    test("GIVEN the user opens the app then they should see the Home Screen", () async {
      //find text from buttons
      final buttonOneTextFinder = find.byValueKey('btc-usd-text');
      final buttonTwoTextFinder = find.byValueKey('usd-btc-text');

      final buttonOneText = await driver.getText(buttonOneTextFinder);
      final buttonTwoText = await driver.getText(buttonTwoTextFinder);
      
      //matching the finder and the actual text on screen
       expect(buttonOneText, equals("BTC to USD"));
       expect(buttonTwoText, equals("USD to BTC"));

    });

    test("GIVEN the user is in the Home Screen THEN taps on BTC to USD it should take them to the conversion screen", () async {
        final buttonOneFinder = find.byValueKey('btc-usd-btn');
        
        driver.tap(buttonOneFinder);

        final convertButtonTextFinder = find.byValueKey('convert-btn-text');
        final convertButtonText = await driver.getText(convertButtonTextFinder);

        expect(convertButtonText, "Convert");

      
    });
    
    test("GIVEN the user is in Conversion Screen THEN taps on 'return' icon it should take them back to the Home Screen", () async {
      final backButtonFinder = find.byValueKey('back-btn');

      driver.tap(backButtonFinder);
      await Future.delayed(Duration(milliseconds: 100));

      final buttonOneTextFinder = find.byValueKey('btc-usd-text');
      final buttonTwoTextFinder = find.byValueKey('usd-btc-text');

      final buttonOneText = await driver.getText(buttonOneTextFinder);
      final buttonTwoText = await driver.getText(buttonTwoTextFinder);

      expect(buttonOneText, equals("BTC to USD"));
      expect(buttonTwoText, equals("USD to BTC"));
    });
    
    
  });
}