import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class CoinPriceinfo {
  String baseUrl = "https://rest.coinapi.io/v1/";
  String apiKey = "49C09C20-3C8F-41BE-90A7-C2DA0F977A37";

  // Get the current price of 1 coin/token ->
  Future<String> getCurrentPriceOfMultipleCoins(String coinSymbol) async {
    var url = Uri.parse("${baseUrl}assets?filter_asset_id=$coinSymbol");

    try {
      var response = await http.get(url, headers: {"X-CoinAPI-Key": apiKey});
      var body = json.decode(response.body);
      var price = body[0]["price_usd"];

      return price;
    } catch (e) {
      print(e);
    }
    return "";
  }

  //  Calculates the value of a specific wallet ->
  // @param = BTC,XRP,ETH,XML
  // @param = amount of coins/tokens someone owns.
  double calculateValueOfWallet(String coinSymbol, int amountOfCoins) {
    return 0.5;
  }
}
