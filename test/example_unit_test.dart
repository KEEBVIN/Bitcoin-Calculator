import 'package:test/test.dart';
import 'package:bitcoin_calculator/conversion_tools.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;


//mockito client to instantiate a variable for API tests
class MockClient extends Mock implements http.Client{}

void main() {


  //neg numbers, 0, and positive numbers

  group("API Tests", () {

    test("returns BTC value on call ", () async {
      //need a fake client
      final client = MockClient();
      //actual api data from time of coding this, but is subject to change, making the data "fake"
      
      final fakeApiData = '{"time":{"updated":"Apr 2, 2023 00:00:00 UTC","updatedISO":"2023-04-02T00:00:00+00:00","updateduk":"Apr 2, 2023 at 01:00 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,477.9168","description":"United States Dollar","rate_float":28477.9168}}}';
      //"API call"
      var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
      //when call is made then mockito responds with an okay sign and returns the fake data
      when(client.get(url))
      .thenAnswer((_) async => http.Response(fakeApiData, 200));

      String btcVal = await ConversionTools.fetchBitcoinVal(client);

      double actual = double.parse(btcVal);

    //string is extracted from fetchBitcoinVal so btcVal should be a string
      expect(actual, isA<double>());
      
      expect(actual, 28477.9168);

    });

    test("Throws an exception is api call results in an error", () async {
          final client = MockClient();
          var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
          when(client.get(url)).thenAnswer((_) async => http.Response("Not Found",404));

          expect(ConversionTools.fetchBitcoinVal(client), throwsException);
      });


  });

//testing function logic here
  group("USD to BTC tests", () {
    
    test('USD to BTC conversion', () async {
    //need a fake client
      final client = MockClient();
      //actual api data from time of coding this, but is subject to change, making the data "fake"
      
      final fakeApiData = '{"time":{"updated":"Apr 2, 2023 00:00:00 UTC","updatedISO":"2023-04-02T00:00:00+00:00","updateduk":"Apr 2, 2023 at 01:00 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,477.9168","description":"United States Dollar","rate_float":28477.9168}}}';
      //"API call"
      var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
      //when call is made then mockito responds with an okay sign and returns the fake data
      when(client.get(url))
      .thenAnswer((_) async => http.Response(fakeApiData, 200));

      String btcVal = await ConversionTools.fetchBitcoinVal(client);

      double actual = double.parse(btcVal);

      double usd = 5;

    //parameters usd,btc (doubles)
      double result = ConversionTools.usdToBtc(usd,actual);

    // we expect the result to be converted correctly
      expect(result, usd * (1/actual));
  });

   test('USD to BTC with decimals', () async {

    // Need a fake client
    final client = MockClient();

    // Actual api data from time of coding this, but is subject to change, making the data "fake"
    final fakeApiData = '{"time":{"updated":"Apr 2, 2023 00:00:00 UTC","updatedISO":"2023-04-02T00:00:00+00:00","updateduk":"Apr 2, 2023 at 01:00 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,477.9168","description":"United States Dollar","rate_float":28477.9168}}}';
    // "API call"

    var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    // When call is made then mockito responds with an okay sign and returns the fake data

    when(client.get(url))
    .thenAnswer((_) async => http.Response(fakeApiData, 200));

    String btcVal = await ConversionTools.fetchBitcoinVal(client);

    double actual = double.parse(btcVal);

    double usd = 1.5;

    // Double parameters usd & btc
    double result = ConversionTools.usdToBtc(usd, actual);
    
    // Expect result
    expect(result,  usd * (1/actual));
   });

  test('USD to BTC conversion with negative number', () {

   expect(() =>  ConversionTools.usdToBtc(-5,-1), throwsArgumentError);
  });

   test('USD to BTC conversion with 0', () {

    expect(() => ConversionTools.usdToBtc(0,0), throwsArgumentError);
  });

  });

  group("BTC to USD tests", () {
    test('BTC to USD conversion', () async {

    // Need a fake client
    final client = MockClient();

    // Actual api data from time of coding this, but is subject to change, making the data "fake"
    final fakeApiData = '{"time":{"updated":"Apr 2, 2023 00:00:00 UTC","updatedISO":"2023-04-02T00:00:00+00:00","updateduk":"Apr 2, 2023 at 01:00 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,477.9168","description":"United States Dollar","rate_float":28477.9168}}}';
    // "API call"

    var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    // When call is made then mockito responds with an okay sign and returns the fake data

    when(client.get(url))
    .thenAnswer((_) async => http.Response(fakeApiData, 200));

    String btcVal = await ConversionTools.fetchBitcoinVal(client);

    double actual = double.parse(btcVal);

    double btc = 5;

    // Double parameters usd & btc
    double result = ConversionTools.btcToUsd(btc, actual);
    //double result = ConversionTools.btcToUsd(3333222,1);

    expect(result, btc * actual);

  });

   test('BTC to USD conversion with decimals', () async {
    // Need a fake client
    final client = MockClient();

    // Actual api data from time of coding this, but is subject to change, making the data "fake"
    final fakeApiData = '{"time":{"updated":"Apr 2, 2023 00:00:00 UTC","updatedISO":"2023-04-02T00:00:00+00:00","updateduk":"Apr 2, 2023 at 01:00 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"28,477.9168","description":"United States Dollar","rate_float":28477.9168}}}';
    // "API call"

    var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    // When call is made then mockito responds with an okay sign and returns the fake data

    when(client.get(url))
    .thenAnswer((_) async => http.Response(fakeApiData, 200));

    String btcVal = await ConversionTools.fetchBitcoinVal(client);

    double actual = double.parse(btcVal);

    double btc = 1.5;

    // Double parameters usd & btc
    double result = ConversionTools.btcToUsd(btc, actual);
    //double result = ConversionTools.btcToUsd(3333222,1);

    expect(result, btc * actual);

  });

  test('BTC to USD conversion with negative number', () {

    expect(() => ConversionTools.btcToUsd(-5,-1), throwsArgumentError);
  });

   test('BTC to USD conversion with 0', () {
    expect(() => ConversionTools.btcToUsd(0,0), throwsArgumentError);
  });

  });
  
  

 
}
