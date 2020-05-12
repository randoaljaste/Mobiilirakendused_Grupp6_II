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
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    title: Text('Overview'),
  ),
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Income: $_income'),
        Text('Expense: $_expense'),
        Text('Balance: $_balance'),
        RaisedButton(
          child: Text('+ Expence'),
          onPressed: () {
            Navigator.pushNamed(context, '/expence');
          },
        ),
        RaisedButton(
          child: Text('+ Income'),
          onPressed: () {
            Navigator.pushNamed(context, '/income');
          },
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


