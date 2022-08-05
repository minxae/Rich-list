import 'dart:convert';

import 'package:http/http.dart' as http;

class RippleApi {
  String baseUrl = "https://s1.ripple.com:51234/"; //

  // fetch account info from blockchain ->
  // @param : wallet address
  // @param : blockchain
  Future<String> fetchAccountInfo(String blockchain, String address) async {
    var url = Uri.parse(baseUrl);
    String body = '';
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
      print(e);
    }

    return "";
  }

  // calculate  the rank of the account by address ->
  int calculateRankByAllAcounts() {
    return 7;
  }
}
