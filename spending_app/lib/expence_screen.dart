import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class ExpenceScreen extends StatefulWidget {
  ExpenceScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ExpenceScreen createState() => _ExpenceScreen();

}
class _ExpenceScreen extends State<ExpenceScreen>{
  double _expense = 0, _increment = 0;
  List<String> _categories = ['Clothes', 'Eating Out', 'Entertainment', 'General', 'Gifts', 'Shopping', 'Travel']; // Option 2
  String _selectedCategory; // Option 2

  DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
  }

  _editExpence() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      final __expense = pref.getDouble('expense') ?? 0.0;
      _expense = __expense + _increment;
      pref.setDouble('expense', _expense);
    });
    Navigator.pushNamed(context, '/');
  }
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Expence'),
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
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            DropdownButton(
              hint: Text('Please choose a category'),
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem(
                  child: new Text(category),
                  value: category,
                );
              }).toList(),
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: _editExpence,
            ),
          ],
        ),
      ),
    );
  }

}

