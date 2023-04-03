import 'package:flutter/material.dart';
import 'conversion_screen.dart';
import 'conversion_tools.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      home: MyHomePage(title: 'Counter App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Value of bitcoin from retrieval in api
  Future<String> currentValue; 
  // Checking what is passed 
  int choice = 0;
  @override
  void initState() {
    super.initState();
    currentValue = ConversionTools.fetchBitcoinVal(httpClient);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text("BTC to USD",
              style: TextStyle(fontSize: 14, color: Colors.black),
              key: Key('btc-usd-text')),
          onPressed: () {

              choice = 1;
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConversionScreen(chosen: choice, currentValue: currentValue,)));
          },
          style: TextButton.styleFrom(
              backgroundColor: Color(0xFF84DCC6),
              minimumSize: Size(280, 46),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          key: Key('btc-usd-btn'),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0,),
          child: ElevatedButton(
            child: Text("USD to BTC",
                style: TextStyle(fontSize: 14, color: Colors.black),
                key: Key('usd-btc-text')),
            onPressed: () {
              choice = 2;
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConversionScreen(chosen: choice, currentValue: currentValue,)));
            },
            style: TextButton.styleFrom(
                backgroundColor: Color(0xFFFFA69E),
                minimumSize: Size(280, 46),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            key: Key('usd-btc-btn')
          ),
        ),
      ],
    )));
  }
}
