import 'package:flutter/material.dart';
import 'package:spendingapp/expence_screen.dart';
import 'package:spendingapp/income_screen.dart';
import 'package:spendingapp/tab_screen.dart';
import 'overview_screen.dart';

void main(){
  runApp(MaterialApp(
    title: 'Spending Application',
    initialRoute: '/tab-screen',
    routes: {
      '/': (context) => OverviewScreen(),
      '/tab-screen': (context) => TabScreen(),
      '/expence': (context) => ExpenceScreen(),
      '/income': (context) => IncomeScreen(),
    },
    theme: ThemeData(
      primarySwatch: Colors.pink,
    ),
  ));
}