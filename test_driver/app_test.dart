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
        
        await driver.tap(buttonOneFinder);

        final convertButtonTextFinder = find.byValueKey('convert-btn-text');
        final convertButtonText = await driver.getText(convertButtonTextFinder);

        expect(convertButtonText, "Convert");

      
    });

    test("GIVEN the user is in the conversion screen AND '1' is input THEN should display 27305.4 USD", () async {

      final textFieldFinder = find.byValueKey('text-field-key');
      final conversionButtonFinder = find.byValueKey('button-key');

      await driver.tap(textFieldFinder);
      await driver.enterText('1');
      await driver.tap(conversionButtonFinder);

      final usdTextFinder = find.byValueKey('valid-text');
      final usdText = await driver.getText(usdTextFinder);

      expect(usdText, "27305.4 USD");


    });
    
    test("GIVEN the user is in Conversion Screen THEN taps on 'return' icon it should take them back to the Home Screen", () async {
      final backButtonFinder = find.byValueKey('back-btn');

      await driver.tap(backButtonFinder);
      await Future.delayed(Duration(milliseconds: 100));

      final buttonOneTextFinder = find.byValueKey('btc-usd-text');
      final buttonTwoTextFinder = find.byValueKey('usd-btc-text');

      final buttonOneText = await driver.getText(buttonOneTextFinder);
      final buttonTwoText = await driver.getText(buttonTwoTextFinder);

      expect(buttonOneText, equals("BTC to USD"));
      expect(buttonTwoText, equals("USD to BTC"));
    });


   test("GIVEN the user is in the Home Screen THEN taps on USD to BTC it should take them to the conversion screen", () async {
        final buttonTwoFinder = find.byValueKey('usd-btc-btn');

        await driver.tap(buttonTwoFinder);

        final convertButtonTextFinder = find.byValueKey('convert-btn-text');
        final convertButtonText = await driver.getText(convertButtonTextFinder);

        expect(convertButtonText, "Convert");

    });

    test("GIVEN the user is in the conversion screen AND '1' is input THEN should display 0.000037 BTC", () async {
      final textFieldFinder = find.byValueKey('text-field-key');
      final conversionButtonFinder = find.byValueKey('button-key');

      await driver.tap(textFieldFinder);
      await driver.enterText('1');
      await driver.tap(conversionButtonFinder);

      final btcTextFinder = find.byValueKey('valid-text');
      final btcText = await driver.getText(btcTextFinder);

      expect(btcText, "0.000037 BTC");

      //set up for next test
      final backButtonFinder = find.byValueKey('back-btn');
      driver.tap(backButtonFinder);


    });



    
    
  });

  group('Sad paths', () {

    test("Given the User is in the Home screen AND selects 'BTC to USD' THEN they tap continue an error message should be displayed", () async {
      final buttonOneFinder = find.byValueKey('btc-usd-btn');

      //move from home screen
     await driver.tap(buttonOneFinder);

      //shuold be in BTC to USD
      final conversionButtonFinder = find.byValueKey('button-key');

      await driver.tap(conversionButtonFinder);
      await Future.delayed(Duration(milliseconds: 100));

      final errorMessageTextFinder = find.byValueKey('error-text');
      final errorMessageText = await driver.getText(errorMessageTextFinder);

      final backButtonFinder = find.byValueKey('back-btn');
      
      
      expect(errorMessageText, equals("Error Input invalid"));

      //next test set up
      await driver.tap(backButtonFinder);

    });

    


   test("Given the User is in the Home screen AND selects 'USD to BTC' THEN they tap continue  an error message should be displayed", () async {
      final buttonTwoFinder = find.byValueKey('usd-btc-btn');

      //move from home screen
      await driver.tap(buttonTwoFinder);

      //should be in USD to BTC
      final conversionButtonFinder = find.byValueKey('button-key');

      await driver.tap(conversionButtonFinder);
      await Future.delayed(Duration(milliseconds: 100));

      final errorMessageTextFinder = find.byValueKey('error-text');
      final errorMessageText = await driver.getText(errorMessageTextFinder);
      
      
      expect(errorMessageText, equals("Error Input invalid"));

    });

    
    
  });


}