
import 'package:coronavirus_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(CoronaVirusTracker());

class CoronaVirusTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
