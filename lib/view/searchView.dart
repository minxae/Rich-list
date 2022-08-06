// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:test/coinFetchMethods/RippleApi.dart';
import 'package:test/view/accountInfoView.dart';
import 'selectCoinView.dart';

class HomePage extends StatefulWidget {
  final String coin;
  const HomePage({Key? key, required this.coin}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchUserWallet = new TextEditingController();
  RippleApi api = RippleApi();

  @override
  Widget build(BuildContext context) {
    var coin = widget.coin;
    Color textColor = Color.fromARGB(255, 49, 49, 49);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
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
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "Rich-List",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: textColor,
                    ),
                  ),
                ),
                Text(
                  coin,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                //subtitle: Fill in your wallet adress and let see!
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Fill in your wallet address',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                ),
                //Input field: Wallet adress "placeholder = wallet Adress"
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: searchUserWallet,
                        decoration: InputDecoration(
                          hintText: "adress...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                //Button to submit wallet adress.
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 8, 138, 245),
                    ),
                    onPressed: () => {NextPage(coin, context)},
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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

  Future<void> NextPage(String coin, BuildContext context) async {
    CircularProgressIndicator();
    if (searchUserWallet.text != "") {
      if (searchUserWallet.text.length > 9) {
        String userInfoObj =
            await api.fetchAccountInfo(coin, searchUserWallet.text);
        if (userInfoObj == "") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Wallet not found on the blockchain"),
            ),
          );
        } else {
          // Go to next page and forward the @userInfoObj to accountInfo page ->
          print(userInfoObj);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => accountInfo(userObject: userInfoObj),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill in a correct wallet address"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in your wallet address."),
        ),
      );
    }
  }
}
