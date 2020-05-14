import 'package:flutter/material.dart';
import 'package:spendingapp/expence_screen.dart';
import 'package:spendingapp/income_screen.dart';
import 'package:spendingapp/overview_screen.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Overview"),
                Tab(icon: Icon(Icons.shopping_basket), text: "Expence"),
                Tab(icon: Icon(Icons.account_balance_wallet), text: "Income"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OverviewScreen(),
              ExpenceScreen(),
              IncomeScreen(),
            ],
          ),
        ),
      ),
    );
  }
}