// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test/coinFetchMethods/CoinPriceInfo.dart';
import 'dart:convert';
import 'searchView.dart';
import 'package:test/coinFetchMethods/RippleApi.dart';

class accountInfo extends StatefulWidget {
  final String
      userObject; // Convert this object to json object to work with  ->
  const accountInfo({Key? key, required this.userObject}) : super(key: key);

  @override
  State<accountInfo> createState() => _accountInfoState();
}

class _accountInfoState extends State<accountInfo> {
  RippleApi api = RippleApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rippleBack.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: ListView(
              //all items in the account info screen
              children: [
                balance(),
                rank(),
                transactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Balance layout
  Widget balance() {
    // style ->
    Color textColor = Color.fromARGB(255, 255, 255, 255);

    // User information ->
    var userInfo = json.decode(widget.userObject);
    var balance =
        int.parse(userInfo["result"]["account_data"]["Balance"]) * 0.000001;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 62, 136, 247),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 41, 41, 41).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text(
                  "Balance",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "XRP/USD",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      color: textColor),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  balance.round().toString() + " XRP",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w300,
                      color: textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rank() {
    CoinPriceinfo coinPriceinfo = CoinPriceinfo();
    var userInfo = json.decode(widget.userObject);
    var balance =
        int.parse(userInfo["result"]["account_data"]["Balance"]) * 0.000001;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 54, 54, 54).withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 4,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              height: 100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4),
                      child: Text(
                        "Rank",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 65, 65, 65),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "#8982",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 65, 65, 65),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 54, 54, 54).withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 4,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              height: 100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4),
                      child: Text(
                        "Value",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 65, 65, 65)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      // future: coinPriceinfo.calculateValueOfWallet(
                      //     "XRP", balance.toInt()),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          double data = double.parse(snapshot.data.toString());
                          return Text(
                            "\$${data.round()}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 65, 65, 65),
                            ),
                          );
                        } else {
                          return Text("No data");
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget transactions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 41, 41, 41).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 65, 65, 65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All the transactions from this address",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 65, 65, 65),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                      future: displayAllTransactionWidgets(),
                      builder: (context, AsyncSnapshot<List<Widget>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              return snapshot.data![index];
                            }),
                          );
                        } else if (snapshot.hasError) {
                          return Text('ERROR : ${snapshot.error.toString()}');
                        } else {
                          return Container(
                            height: 200,
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionItem(dynamic txObject, String address) {
    var txDestination = txObject["Destination"];
    var txAmount = txObject["Amount"] ?? "0";
    var calcAmount = int.parse(txAmount) * 0.000001;
    Color txColor = Color.fromARGB(255, 255, 255, 255);
    if (address != txDestination) {
      txColor = Colors.redAccent;
    }
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 9.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            txObject["hash"],
            style: TextStyle(
                fontWeight: FontWeight.w200,
                color: Color.fromARGB(237, 2, 2, 2),
                fontSize: 10),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 62, 136, 247),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        txObject["TransactionType"],
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white54,
                            fontSize: 10),
                      ),
                    ),
                    Text(
                      txObject["Account"].toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Icon(
                      Icons.swipe_down_alt,
                      color: Color.fromARGB(255, 252, 252, 252),
                      size: 20,
                    ),
                    Text(
                      txObject["Destination"].toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${calcAmount.round().toString()} XRP',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: txColor,
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Future<List<Widget>> displayAllTransactionWidgets() async {
    List<Widget> transactions = [];
    RippleApi rippleApi = RippleApi();
    var accountObj = json.decode(widget.userObject);
    var address = accountObj["result"]["account_data"]["Account"];

    try {
      var txCallObj = await rippleApi.getTxHistoryIformation(address);
      var txDecode = jsonDecode(txCallObj);
      var allTxInfo = txDecode["result"]["transactions"];

      if (allTxInfo.length != 0) {
        for (int i = 0; i < allTxInfo.length; i++) {
          var result = allTxInfo[i]["tx"];
          if (result["TransactionType"] == "Payment" &&
              result["Amount"].runtimeType == String) {
            transactions.add(transactionItem(result, address));
          }
        }
      } else {
        transactions.add(Text("No transactions found"));
      }

      return transactions;
    } catch (e) {
      print(e);
      return transactions;
    }
  }
}
