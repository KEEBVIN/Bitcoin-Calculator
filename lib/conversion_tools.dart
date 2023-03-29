class ConversionTools{

  static double usdToBtc(double usd){

    if(usd <= 0){
      throw ArgumentError();
    }
    double btc = 27305.40;

    double exchange = usd * btc;

    return exchange;
  }

  static double btcToUsd(double btc){

    if(btc <= 0 ){
      throw ArgumentError();
    }
    double usd = 0.000037;

    double exchange = usd * btc;

    return exchange;
  }
}