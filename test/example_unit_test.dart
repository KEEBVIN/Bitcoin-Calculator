import 'package:test/test.dart';
import 'package:bitcoin_calculator/conversion_tools.dart';

void main() {


  //neg numbers, 0, and positive numbers
  group("USD to BTC tests", () {
      test('USD to BTC conversion', () {
    double result = ConversionTools.usdToBtc(5);

    expect(result, 5 * 27305.40);
  });

   test('USD to BTC with decimals', () {
    double result = ConversionTools.usdToBtc(1.5);

    expect(result, 1.5 * 27305.40);
   });

  test('USD to BTC conversion with negative number', () {

   expect(() =>  ConversionTools.usdToBtc(-5), throwsArgumentError);
  });

   test('USD to BTC conversion with 0', () {

    expect(() => ConversionTools.usdToBtc(0), throwsArgumentError);
  });

  });

  group("BTC to USD tests", () {
    test('USD to BTC conversion', () {
    double result = ConversionTools.btcToUsd(3333222);

    expect(result, 3333222 * 0.000037);

  });

   test('BTC to USD conversion with decimals', () {
    double result = ConversionTools.btcToUsd(35.49);

    expect(result, 35.49 * 0.000037);
  });

  test('BTC to USD conversion with negative number', () {

    expect(() => ConversionTools.btcToUsd(-5), throwsArgumentError);
  });

   test('BTC to USD conversion with 0', () {
    expect(() => ConversionTools.btcToUsd(0), throwsArgumentError);
  });

  });
  
  

 
}
