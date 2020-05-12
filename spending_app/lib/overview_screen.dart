import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OverviewScreen createState() => _OverviewScreen();

}
class _OverviewScreen extends State<OverviewScreen>{
  double _income = 0, _expense = 0, _balance = 0;
  List<String> _transactions = [];
  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  _loadInfo() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _income = (pref.getDouble('income') ?? 0.0);
      _expense = (pref.getDouble('expense') ?? 0.0);
      _balance = _income - _expense;

      _transactions = (pref.getStringList('transactions') ?? []);


    });
  }
  _clearData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _income = 0.0;
      pref.setDouble('income', _income);
      _expense = 0.0;
      pref.setDouble('expense', _expense);
      _balance = _income - _expense;
      _transactions = [];
      pref.setStringList('transactions', _transactions);

    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    title: Text('Overview'),
    actions: <Widget>[
    // action button
    IconButton(
    icon: Icon(Icons.add),
    onPressed: () {
      Navigator.pushNamed(context, '/expence_and_income_tab');
    },
  ),
    ],
  ),
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Income: $_income'),
        Text('Expense: $_expense'),
        Text('Balance: $_balance'),
        new Column( // Or Row or whatever :)
          children: _transactions.map((text) => Text(text, style: TextStyle(color: Colors.blue),)).toList(),
        ),
        RaisedButton(
          child: Text('Clear data'),
          onPressed: _clearData,
        ),
        ],
      ),
    ),

  );
  }
}


