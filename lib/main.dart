import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text("BTC to USD",
              style: TextStyle(fontSize: 14, color: Colors.black)),
          onPressed: () => {},
          style: TextButton.styleFrom(
              backgroundColor: Color(0xFF84DCC6),
              minimumSize: Size(280, 46),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0,),
          child: ElevatedButton(
            child: Text("USD to BTC",
                style: TextStyle(fontSize: 14, color: Colors.black)),
            onPressed: () => {},
            style: TextButton.styleFrom(
                backgroundColor: Color(0xFFFFA69E),
                minimumSize: Size(280, 46),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
      ],
    )));
  }
}
