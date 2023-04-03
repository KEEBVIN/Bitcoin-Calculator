import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:bitcoin_calculator/globals.dart' as globals;
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

//making a class to use mockito
class MockClient extends Mock implements http.Client {}


void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

   //grabbing mock client 
  final MockClient client = MockClient();

  final fakeApiData =
      '{"time":{"updated":"Apr 2, 2023 00:00:00 UTC","updatedISO":"2023-04-02T00:00:00+00:00","updateduk":"Apr 2, 2023 at 01:00 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,477.9168","description":"United States Dollar","rate_float":28477.9168}}}';
  //"API call"
  var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
  //when call is made then mockito responds with an okay sign and returns the fake data
  when(client.get(url))
      .thenAnswer((_) async => http.Response(fakeApiData, 200));

  globals.httpClient = client;
  

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
