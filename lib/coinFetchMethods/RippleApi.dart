import 'dart:convert';

import 'package:http/http.dart' as http;

class RippleApi {
  String baseUrl = "https://s2.ripple.com:51234/"; //

  // fetch account info from blockchain ->
  // @param : wallet address
  // @param : blockchain
  Future<String> fetchAccountInfo(String blockchain, String address) async {
    var url = Uri.parse(baseUrl);
    try {
      var response = await http.post(url,
          body: jsonEncode({
            "method": "account_info",
            "params": [
              {
                "account": address,
                "strict": true,
                "ledger_index": "current",
                "queue": true
              }
            ]
          }));

      var jsonString = response.body;
      var jsonObject = json.decode(jsonString);

      if (jsonObject["result"]["status"] == "error") {
        return "";
      } else {
        return jsonString;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // calculate  the rank of the account by address ->
  int calculateRankByAllAcounts() {
    return 7;
  }

  // Get all transactions from a wallet address
  // @param : Wallet address
  Future<String> getTxHistoryIformation(String address) async {
    var url = Uri.parse(baseUrl);
    try {
      var response = await http.post(url,
          body: jsonEncode({
            "method": "account_tx",
            "params": [
              {
                "account": address,
                "binary": false,
                "forward": false,
                "ledger_index_max": -1,
                "ledger_index_min": -1,
                "limit": 5
              }
            ]
          }));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Oops.. Something went wrong";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
