import 'package:flutter/material.dart';
import 'package:spendingapp/expence_screen.dart';
import 'package:spendingapp/income_screen.dart';
import 'overview_screen.dart';

void main(){
  runApp(MaterialApp(
    title: 'Spending Application',
    initialRoute: '/',
    routes: {
      '/': (context) => OverviewScreen(),
      '/expence': (context) => ExpenceScreen(),
      '/income': (context) => IncomeScreen(),
    },
  ));
}