import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'conversion_tools.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({Key key, @required this.chosen}) : super(key: key);
  final int chosen;

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final textFieldController = TextEditingController();
  bool input = true;
  bool valid = false;
  //if choice == true then it chose the first button, otherwise it is the second button
  bool choice = true;
  double val = 0;

  void checkInput() {
    String inputText = textFieldController.text;
    if (inputText.length < 1) {
      input = false;
      valid = false;
    } else {
      input = true;
      valid = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ***BACK BUTTON***
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color(0xFF4C748B)),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
            key: Key('back-btn'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                valid ? (choice ? "${val} USD" : "${val} BTC") : "",
                style: TextStyle(fontSize: 20, color: Colors.green),
                key: Key('valid-text'),
              ),
              // ***TEXT BOX***
              Container(
                  child: Card(
                child: TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xFF3DB8E)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xFF2274A5)),
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Color(0xFFFFFF),
                      filled: true),
                  key: Key('text-field-key'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                    TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                        text: newValue.text.replaceAll('.', '.'),
                      ),
                    ),
                  ],
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      input ? "" : "Error Input invalid",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                      key: Key('error-text'),
                    ),
                  )
                ],
              ),

              // ***CONTINUE BUTTON***
              ElevatedButton(
                  onPressed: () {
                    checkInput();

                    if (widget.chosen == 1) {
                      choice = true;
                      if (input) {
                        val = ConversionTools.usdToBtc(
                            double.parse(textFieldController.text));
                      } else {}
                    } else {
                      choice = false;
                      if (input) {
                        val = ConversionTools.btcToUsd(
                            double.parse(textFieldController.text));
                      } else {}
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Color(0xFFFFA69E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Convert',
                      style: TextStyle(fontSize: 14),
                      key: Key('convert-btn-text')),
                  key: Key('button-key')),
            ],
          ),
        ));
  }
}
