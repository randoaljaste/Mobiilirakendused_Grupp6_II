import 'package:flutter/material.dart';
import 'package:spendingapp/expence_screen.dart';
import 'package:spendingapp/income_screen.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.shopping_basket), text: "Expence"),
                Tab(icon: Icon(Icons.account_balance_wallet), text: "Income")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ExpenceScreen(),
              IncomeScreen(),
            ],
          ),
        ),
      ),
    );
  }
}