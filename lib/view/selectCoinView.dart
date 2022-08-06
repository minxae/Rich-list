// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:test/coinFetchMethods/CoinPriceInfo.dart';
import 'searchView.dart';

class coinView extends StatefulWidget {
  const coinView({Key? key}) : super(key: key);

  @override
  State<coinView> createState() => _coinViewState();
}

class _coinViewState extends State<coinView> {
  @override
  Widget build(BuildContext context) {
    Color textColor = Color.fromARGB(255, 54, 54, 54);
    CoinPriceinfo coinPriceinfo = CoinPriceinfo();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rippleBack.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icon
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.all_inclusive,
                    color: textColor,
                    size: 100,
                  ),
                ),
                //Header: Rich-List
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Rich-List",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: textColor,
                    ),
                  ),
                ),

                //subtitle:select your wallet!
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select your type of wallet.",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                ),
                //Input field: Wallet adress "placeholder = wallet Adress"

                //Button to submit wallet adress.

                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25,
                  ),
                  child: Container(
                    height: 300,
                    child: ListView(
                      children: <Widget>[
                        coinItem("Bitcoin", "BTC"),
                        coinItem("XRP", "XRP"),
                        coinItem("Ethereum", "ETH"),
                        coinItem("Stellar", "XLM"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Your coin not on the list? request it at",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: Add futureBuilder inside this widget to make the call
  Widget coinItem(String coin, String coinSymbol) {
    Color textColor = Color.fromARGB(255, 80, 80, 80);

    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              coin: coin,
            ),
          ),
        )
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: Color.fromARGB(137, 189, 189, 189)),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 41, 41, 41).withOpacity(0.5),
                spreadRadius: -4,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: Text(
                    coin,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$coin.png'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
