import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OverviewScreen createState() => _OverviewScreen();

}
class _OverviewScreen extends State<OverviewScreen>{
  double _counter = 0;
  double _increment = 0;
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _counter = (pref.getDouble('counter') ?? 0.0);
    });
  }
  _incrementCounter() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      final myDouble = pref.getDouble('counter') ?? 0.0;
      _counter = myDouble + _increment;
      pref.setDouble('counter', _counter);
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    title: Text('Teine leht'),
  ),
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Meie loendaja'),
        Text('$_counter'),
        new TextField(
          decoration: new InputDecoration(labelText: "Enter your number"),
          keyboardType: TextInputType.number,
          onChanged: (text) {
            setState(() {
              _increment = double.tryParse(text);
            });
          },// Only numbers can be entered

        ),
        Text('$_increment'),
        RaisedButton(
          child: Text('Loendaja'),
          onPressed: _incrementCounter,
          ),
        ],
      ),
    ),
  );
  }

}


