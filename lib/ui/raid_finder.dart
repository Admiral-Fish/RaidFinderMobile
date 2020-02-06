import 'package:flutter/material.dart';
import 'package:raidfinder/ui/generator.dart';

class RaidFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'RaidFinder', home: Generator());
  }
}
