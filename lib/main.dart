import 'package:flutter/material.dart';
import 'package:flutter_bi0_metric_testing/dashboard.dart';
import 'package:flutter_bi0_metric_testing/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}
