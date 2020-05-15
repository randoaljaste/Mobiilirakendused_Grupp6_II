import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://gravuur.ee/mobiilirakendused/db.php";

class API {
  static Future getTransactions() {
    var url = baseUrl;
    return http.get(url);
  }
}

class User {
  double amount;
  String calendar;
  String category;

  User(double amount, String calendar, String category) {
    this.amount = amount;
    this.calendar = calendar;
    this.category = category;
  }

  User.fromJson(Map json)
      : amount = json['amount'],
        calendar = json['calendar'],
        category = json['category'];

  Map toJson() {
    return {'amount': amount, 'calendar': calendar, 'category': category};
  }
}

class OverviewScreen extends StatefulWidget {
  OverviewScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OverviewScreen createState() => _OverviewScreen();

}
class _OverviewScreen extends State<OverviewScreen>{
  double _income = 0, _expense = 0, _balance = 0, fromDBValue = 0;
  List<String> _transactions = [];
  var transactions = new List<User>();


  @override
  void initState() {
    super.initState();
    _loadInfo();
    _getTransactions();
    //_clearData();
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


  _getTransactions() {
    API.getTransactions().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        var test = json.decode(response.body);
        print(test.length);
        for (int i = 0; i < test.length; i++) {
          print(test[i]['amount']);
          fromDBValue += test[i]['amount'];
        }
        print(fromDBValue);
        _submitData();
        transactions = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }
  _submitData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      final __expense = pref.getDouble('expense') ?? 0.0;
      _expense = __expense + fromDBValue;
      pref.setDouble('expense', _expense);
      _balance = _income - _expense;
    });
    //Navigator.pushReplacementNamed(context, "/");
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
    return Column(
      children: <Widget>[
        Container(
          height: 100,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text('Income: $_income'),
            Text('Expense: $_expense'),
            Text('Balance: $_balance'),
                RaisedButton(
                  child: Text('Clear data'),
                  onPressed: _clearData,
                ),
  ],),
        ),
      Container(
      height: 450,
      child: transactions.isEmpty
      ? Column(
        children: <Widget>[
          Text(
            'No transactions added yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )
      : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}'),
                  ),
                ),
              ),
              title: Text(
                transactions[index].category,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                  '\$${transactions[index].calendar}'),
              ),
            );
          },
          itemCount: transactions.length,
      ),
    ),
  ],);}
}


