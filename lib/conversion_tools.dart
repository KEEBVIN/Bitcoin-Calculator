import 'package:http/http.dart' as http;
import 'dart:convert';

class ConversionTools {

  static Future<String> fetchBitcoinVal(http.Client client) async {
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
     
      double btcVal = json["bpi"]["USD"]["rate_float"];
      String rateFloat = btcVal.toString();
      return rateFloat;
    } else {
      throw Exception('Failed to load');
    }
  }
// Have double USD and BTC for both

// From American Dollar value to Bitcoin
  static double usdToBtc(double usd, double btc) {
    if (btc <=0 || usd <= 0) {
      throw ArgumentError();
    }

    double exchange = usd * (1/btc);

    return exchange;
  }
// From Bitcoin value to American Dollar Value
// Double USD will hold a default USD value

  static double btcToUsd(double btc, double btcVal) {
    if (btc <=0 || btcVal <= 0) {
      throw ArgumentError();
    }

    double exchange =  btc * btcVal;

    return exchange;
  }
}
