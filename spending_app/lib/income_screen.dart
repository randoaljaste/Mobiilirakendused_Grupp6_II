import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeScreen extends StatefulWidget {
  IncomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IncomeScreen createState() => _IncomeScreen();

}
class _IncomeScreen extends State<IncomeScreen>{
  double _income = 0, _increment = 0;
  @override
  void initState() {
    super.initState();
  }

  _editIncome() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      final __income = pref.getDouble('income') ?? 0.0;
      _income = __income + _increment;
      pref.setDouble('income', _income);
    });
    Navigator.pushNamed(context, '/');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Income'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new TextField(
              decoration: new InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  _increment = double.tryParse(text);
                });
              },
              // Only numbers can be entered

            ),
            Text('Date'),
            Text('Category'),
            Text('Note'),
            RaisedButton(
              child: Text('Save'),
              onPressed: _editIncome,
            ),
          ],
        ),
      ),
    );
  }

}


