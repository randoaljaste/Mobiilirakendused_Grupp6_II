import 'package:flutter/material.dart';
import 'overview_screen.dart';

void main(){
  runApp(MaterialApp(
    title: 'Spending Application',
    initialRoute: '/',
    routes: {
      '/': (context) => OverviewScreen(),
    },
  ));
}