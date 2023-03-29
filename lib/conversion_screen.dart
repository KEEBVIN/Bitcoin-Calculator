import 'package:flutter/material.dart';
import 'main.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({Key key, @required this.chosen})
      : super(key: key);
  final int chosen;


  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ***BACK BUTTON***
          Row(
            children: [
              IconButton(
                key: Key("back-btn"),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF2274A5),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          // ***TEXT BOX***
          Container(
              child: Card(
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(0xFF3DB8E)),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF2274A5)),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color(0xFFFFFF),
                  filled: true),
              key: Key('text-field-key'),
            ),
          )),
          // ***CONTINUE BUTTON***
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Color(0xFFFFA69E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Convert', style: TextStyle(fontSize: 14), key: Key('convert-btn-text')),
              key: Key('button-key')),
        ],
      ),
    ));
  }
}
