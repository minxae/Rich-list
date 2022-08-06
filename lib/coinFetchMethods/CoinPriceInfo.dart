import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class CoinPriceinfo {
  String baseUrl = "https://rest.coinapi.io/v1/";
  String apiKey = "49C09C20-3C8F-41BE-90A7-C2DA0F977A37";

  // Get the current price of 1 coin/token ->
  Future getCurrentPriceOfMultipleCoins(List coinSymbol) async {
    var urlConcat = "${baseUrl}assets?filter_asset_id=";

    for (var i = 0; i < coinSymbol.length; i++) {
      urlConcat += "${coinSymbol[i]};";
    }
    var urlParse = Uri.parse(urlConcat);

    try {
      var response =
          await http.get(urlParse, headers: {"X-CoinAPI-Key": apiKey});
      var body = json.decode(response.body);
      return body;
    } catch (e) {
      print(e);
    }
    return 1.0;
  }

  //  Calculates the value of a specific wallet ->
  // @param = BTC,XRP,ETH,XML
  // @param = amount of coins/tokens someone owns.
  Future<num> calculateValueOfWallet(
      String coinSymbol, int amountOfCoins) async {
    print("asdasd");
    var coinPriceObj = await getCurrentPriceOfMultipleCoins([coinSymbol]);
    var coinPrice = coinPriceObj[0]["price_usd"];
    var result = amountOfCoins * coinPrice;

    return result;
  }
}
